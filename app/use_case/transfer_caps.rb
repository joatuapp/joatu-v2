class TransferCaps
  include SimpleUsecase::Usecase
  include SimpleUsecase::Preparable

  attr_accessor :form

  def initialize(transaction_form, auth_context)
    self.form, self.auth_context = transaction_form, auth_context
    self.model = form.model
  end

  def prepare
    authorize!
    validate!
  end

  def commit_within_transaction!
    # NOTE: Locking these records during update so that other processes cannot
    # double-spend points.
    form.source.lock.caps -= form.caps
    form.destination.lock.caps += form.caps

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
