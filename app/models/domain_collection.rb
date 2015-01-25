class DomainCollection < SimpleDelegator
  def initialize(model_class, collection)
    @model_class, @collection = model_class, collection
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
