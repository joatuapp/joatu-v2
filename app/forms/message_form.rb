class MessageForm < ApplicationForm
  def self.policy_class
    MessagePolicy
  end

  property :recipients, type: Array[User]
  property :subject, validates: {presence: true}
  property :body, validates: {presence: true}
end
