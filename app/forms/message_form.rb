class MessageForm < ApplicationForm
  def self.policy_class
    MessagePolicy
  end

  property :recipients, type: Array[DomainModel.attr_type(:User)]
  property :subject, validates: {presence: true}
  property :body, validates: {presence: true}
end
