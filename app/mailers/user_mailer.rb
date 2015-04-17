class UserMailer < Devise::Mailer

  def invitation_instructions(record, token, opts={})
    options = {
      template: 'mandrill-joatu-invite',
      subject: I18n.t('devise.mailer.invitation_instructions.subject'),
      name: record.name,
      email: record.email,
      global_merge_vars: [
        {
          name: "accept_invitation_link_en",
          content: accept_user_invitation_url(record, :format => :html, :locale => :en, :invitation_token => token),
        },
        {
          name: "accept_invitation_link_fr",
          content: accept_user_invitation_url(record, :format => :html, :locale => :fr, :invitation_token => token),
        }
      ]
    }

    mandrill_send options
  end

  private

  def mandrill_send(opts={})
    Rails.logger.debug "Mandril send with opts: #{opts.inspect}"
    message = { 
      :subject=> "#{opts[:subject]}", 
      :from_name=> "JoatU",
      :from_email=>"info@joatu.org",
      :to=> [{
        "name"=>opts[:name],
        "email"=>"#{opts[:email]}",
        "type"=>"to"
      }],
      :global_merge_vars => opts[:global_merge_vars]
    }
    MANDRILL.messages.send_template opts[:template], [], message
  rescue Mandrill::Error => e
    Rails.logger.debug("#{e.class}: #{e.message}")
    raise
  end
end
