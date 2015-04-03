require 'reform/form/coercion'

class ApplicationForm < Reform::Form
  include Coercion
end
