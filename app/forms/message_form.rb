class MessageForm < ApplicationForm
  def self.policy_class
    MessagePolicy
  end

  property :recipients
  property :subject, validates: {presence: true}
  property :body, validates: {presence: true}
end
