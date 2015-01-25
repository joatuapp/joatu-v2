class DomainModel
  include Virtus.model strict: true
  include ActiveModel::Model

  class << self
    # None returns an empty collection object.
    def none
      model_class.none
    end

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

    def association(assoc_name, other_model, options = {})
      define_method assoc_name do
        @domain_associations ||= {}
        @domain_associations[assoc_name] ||= other_model.to_s.constantize.new(model.send(assoc_name))
      end

      define_method "#{assoc_name}=" do |val|
        @domain_associations ||= {}
        @domain_associations[assoc_name] = DomainModel.attr_type(other_model.to_sym).new().coerce(val)
      end
    end

    def collection(collection_name, other_model, options = {})
      define_method collection_name do
        @domain_collections ||= {}
        @domain_collections[collection_name] ||= DomainCollection.new(other_model, model.send(collection_name))
      end

      define_method "#{collection_name}=" do |val|
        unless val.respond_to? :each
          val = [val]
        end
        @domain_collections ||= {}
        @domain_collections[collection_name] = DomainCollection.coerce(other_model, val)
      end
    end


    def query
      wrap_query_results(yield self.model_class)
    end

    # Generates and returns an Virtus::Attribute object to coerce objects
    # into instances of type_class. Works for collections as well.
    def attr_type(type_class)
      @generated_attribute_classes ||= {}
      @generated_attribute_classes[type_class] ||= Class.new(Virtus::Attribute) do
        define_method :initialize do |*args|
          unless args.empty?
            super(*args)
          end
        end

        define_method :type do
          type_class.to_s.constantize
        end

        define_method :coerce do |value|
          if value.present?
            if value.is_a? ActiveRecord::Base
              value = type.new(value)
            elsif !value.is_a?(type)
              value = type.query {|m| m.find(value) }
            end
          end
          value
        end
      end
    end
    
    private

    def wrap_query_results(results)
      if results.respond_to? :each
        DomainCollection.new(self, results)
      else
        self.new results
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
