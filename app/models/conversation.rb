class Conversation < DomainModel
  self.model_class = Mailboxer::Conversation

  attribute :subject

  def is_participant?(messageable)
    model.is_participant? messageable
  end

  def self.query
    results = yield Queries.new(model_class)
    if results.respond_to? :each
      results.collect {|mdl| self.new(mdl) }
    else
      self.new results
    end
  end

  def persist!
    raise "Not implemented"
  end

  class Queries
    def initialize(model_class)
      @model = model_class
    end

    def user_conversations(user, box)
      user.mailbox.send(box)
    end

    # Route anything not explicitly defined / overriden through to the
    # underlying model class:
    def method_missing(method, *args)
      @model.send(method, *args)
    end
  end
end
