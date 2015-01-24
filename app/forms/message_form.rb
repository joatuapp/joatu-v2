class MessageForm < ApplicationForm
  def self.policy_class
    MessagePolicy
  end

  property :recipients, type: DomainModel.attr_type(User, collection: true)
  property :subject, validates: {presence: true}
  property :body, validates: {presence: true}
end
