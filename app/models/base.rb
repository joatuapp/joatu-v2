class Base < ActiveRecord::Base
  self.abstract_class = true

  def self.paginate(pagination)
    page(pagination.page).per(pagination.per)
  end
end
PaginationOptions = Struct.new(:page, :per)
