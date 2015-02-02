class Base < ActiveRecord::Base
  self.abstract_class = true

  include Paginatable
end
