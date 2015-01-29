class MessageForm < ApplicationForm
  def self.policy_class
    MessagePolicy
  end

  property :recipients, type: Array[User]
  property :subject, validates: {presence: true}
  property :body, validates: {presence: true}

  def recipients= (val)
    if val.is_a?(Array) && val.first.is_a?(String)
      super User.find(val)
    else
      super
    end
  end
end
