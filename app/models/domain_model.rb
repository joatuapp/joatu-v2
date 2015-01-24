class DomainModel
  include Virtus.model strict: true
  include ActiveModel::Model

  class << self

    def model_class=(val)
      unless val.is_a? Class
        raise "Must set DomainModel's 'model_class' with a class. #{val} given."
      end
      @model_class = val
    end

    def model_class
      @model_class ||= 
        begin
          klass_name = self.name.camelize
          if Persistent.const_defined?(klass_name)
            "Persistent::#{klass_name}".constantize
          else
            raise "No Persistance model found for Domain model #{self.name}"
          end
        end
    end

    def query
      results = yield self.model_class
      if results.respond_to? :each
        results.collect {|mdl| self.new(mdl) }
      else
        self.new results
      end
    end

    # Generates and returns an Virtus::Attribute object to coerce objects
    # into instances of type_class. Works for collections as well.
    def attr_type(type_class, options = {})
      options[:collection] ||= false

      @generated_attribute_classes ||= {}
      @generated_attribute_classes[type_class] ||= {}
      if options[:collection]
        return @generated_attribute_classes[type_class][:collection] ||= Class.new(Virtus::Attribute) do
          default lambda {|m,a| [type_class.new] }

          define_method :type do
            type_class
          end

          define_method :coerce do |value|
            # If value is not already a collection, wrap it in one.
            unless value.respond_to? :each
              value = [value]
            end

            if value.present? && !value.first.is_a?(type)
              value = type.query {|m| m.find(value) }
            end
            value
          end
        end
      else
        return @generated_attribute_classes[type_class][:single] ||= Class.new(Virtus::Attribute) do
          default lambda {|m,a| type_class.new }

          define_method :type do
            type_class
          end

          define_method :coerce do |value|
            if value.present? && !value.is_a?(type)
              if value.respond_to? :each
                raise "Cannot coerce collection into single instance of #{type_class}"
              end

              value = type.query {|m| m.find(value) }
            end
            value
          end
        end
      end
    end
  end

  attr_reader :model

  attribute :id, nil, writer: :private

  def initialize(initial = nil)
    if initial.present? && !initial.is_a?(Hash)
      self.model = initial
      super Hash.new
      populate_from_model!
    else
      self.model = self.class.model_class.new
      super Hash.new
      populate_from_model!
      super initial
    end
  end

  def persist!
    raise "Cannot persist a destroyed object!" if destroyed?

    attrs = self.attributes.inject({}) do |hash, (attr, val)|
      if val.is_a? DomainModel
        hash[attr] = val.model
      else
        hash[attr] = val
      end
      hash
    end
    model.update!(attrs)
    populate_from_model!

    self
  end
  def save
    persist!
  end

  def destroy!
    model.destroy!
    @destroyed = true
    self.freeze
    self
  end

  def destroyed?
    !!@destroyed
  end
  
  private

  attr_writer :model

  def populate_from_model!
    attributes.keys.each do |attr|
      model_val = model.send(attr)
      unless model_val.nil?
        send("#{attr}=", model_val)
      end
    end
  end

  # Delegate a few getter methods to the underlying model for smoother
  # integration with rails as a whole:
  delegate :persisted?, :to_key, to: :model
end
