class DomainCollection < SimpleDelegator
  include Enumerable

  def self.[](model)
    self.new(model.class)
  end

  def self.coerce(model_class, collection)
    if collection.first.is_a?(String) || collection.first.is_a?(Numeric)
      model_class.to_s.constantize.query {|m| m.find(collection) }
    else
      self.new(model_class, collection)
    end
  end

  def current_page
    @collection.current_page
  end

  def initialize(model_class, collection = nil)
    @model_class = model_class.to_s.constantize
    @collection  = collection || @model_class.none
    super @collection
  end

  def name
    "DomainCollection"
  end

  def each(*args, &block)
    @collection.each do |instance|
      block.call @model_class.new(instance)
    end
  end

  def to_ary
    @collection.to_ary.map {|m| @model_class.new(m)}
  end
end
