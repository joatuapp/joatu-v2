module Paginatable
  extend ActiveSupport::Concern

  module ClassMethods
    def paginate(pagination)
      unless pagination.per == :all
        page(pagination.page).per(pagination.per)
      end
    end
  end
end

PaginationOptions = Struct.new(:page, :per)
