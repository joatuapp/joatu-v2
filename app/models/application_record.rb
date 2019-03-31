class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Paginatable

  NullObject = Naught.build
  include NullObject::Conversions
  extend NullObject::Conversions
end
