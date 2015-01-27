class ApplicationForm < Reform::Form
  def persisted?
    if model.respond_to? :persisted?
      model.persisted?
    else
      false
    end
  end

  def to_key
    if model.respond_to? :to_key
      model.to_key
    else
      [""]
    end
  end
end
