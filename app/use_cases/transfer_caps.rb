class TransferCaps
  include SimpleUsecase::All
  include Contracts

  attr_accessor :form

  Contract CapsTransactionForm, User => nil 
  def initialize(transaction_form, auth_context)
    self.form, self.auth_context = transaction_form, auth_context
    self.model = form.model
    nil
  end

  def prepare
    authorize!
    validate!
  end

  def commit_within_transaction!
    # NOTE: Locking these records during update so that other processes cannot
    # double-spend points.
    form.source.with_lock do
      form.source.caps -= form.caps
    end
    form.destination.with_lock do
      form.destination.caps += form.caps
    end

    form.save # Saves the caps transaction.
    form.source.save
    form.destination.save
  end

  private

  def validate!
    raise UnauthorizedError.new unless form.valid?
  end

  def authorize!
    policy.create?
  end
end
