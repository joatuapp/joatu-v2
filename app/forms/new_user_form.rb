class NewUserForm < ApplicationForm
  property :email, validates: {presence: true}
  property :password, validates: {presence: true, length: { minimum: 8 } }
  property :postal_code, validates: {presence: true}

  property :password_confirmation, validates: {presence: true, length: { minimum: 8 } }

  validate :password_ok?

  property :tou_agreement, virtual: true

  validate :tou_agreement do |instance|
    # Emulate the behavior of AcitveRecord's 'validates acceptance', which
    # doesn't seem to work on forms :(
    agreed = (instance.tou_agreement || 0).to_i == 1
    unless agreed
      instance.errors.add(:tou_agreement, I18n.t('tou.form.error_message'))
    end
  end

  property :invitation_token

  def password_ok?
    errors.add(:password_confirmation, "Password mismatch") if password != password_confirmation
  end
end
