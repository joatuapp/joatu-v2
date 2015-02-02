module Paginatable
  extend ActiveSupport::Concern

  module ClassMethods
    def paginate(pagination)
      page(pagination.page).per(pagination.per)
    end
  end
end

PaginationOptions = Struct.new(:page, :per)
