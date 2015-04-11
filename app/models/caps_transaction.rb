class CapsTransaction < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  belongs_to :destination, polymorphic: true

  monetize :caps_cents

  def source
    if source_type == "CapsGenerator"
      CapsGenerator.instance
    else
      super
    end
  end

  def destination
    if destination_type == "CapsGenerator"
      CapsGenerator.instance
    else
      super
    end
  end
end
