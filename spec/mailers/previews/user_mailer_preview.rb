
class UserMailerPreview < ActionMailer::Preview
  def invitation_instructions_preview
    user = User.last
    raw, enc = Devise.token_generator.generate(user.class, :invitation_token)
    @raw_invitation_token = raw
    user.invitation_token = enc
    user.save!
    UserMailer.invitation_instructions(user, raw)
  end
end
