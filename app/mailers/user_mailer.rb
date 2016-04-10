require 'mail'
class UserMailer < Devise::Mailer

  def invitation_instructions(record, token, opts={})
    @invited_user = record
    @invitation_token = token

    to_address = Mail::Address.new @invited_user.email # ex: "john@example.com"
    to_address.display_name = @invited_user.name.dup # ex: "John Doe"
    # Set the From or Reply-To header to the following:
    # address.format # returns "John Doe <john@example.com>"
    mail(
      to: to_address,
      subject: I18n.t('devise.mailer.invitation_instructions.subject'),
    )
  end
end
