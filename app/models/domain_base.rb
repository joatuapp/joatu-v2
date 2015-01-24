class DomainBase
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
      if val.is_a? DomainBase
        hash[attr] = val.model
      else
        hash[attr] = val
      end
      hash
    end
    model.update!(attrs)
    populate_from_model!
  end
  alias :save :persist! # For integration with reform.

  def destroy!
    model.destroy!
    @destroyed = true
    self.freeze
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
