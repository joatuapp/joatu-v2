class ApplicationRecord < ApplicationRecord
  self.abstract_class = true

  include Paginatable

  NullObject = Naught.build
  include NullObject::Conversions
  extend NullObject::Conversions
end
