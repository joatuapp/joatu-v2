class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_box, except: [:new]

  respond_to :html

  def new
    @form = MessageForm.new(Message.new)
    if params[:receiver].present?
      receiver = User.find(params[:receiver])
      @form.recipients = receiver.id
    end
    authorize @form.model
    @message = @form
  end

  def create
    # TODO: Add permissions handling to check against the UserPolicy
    # send_message_to? method.
    @form = MessageForm.new(Message.new)
    if @form.validate(params[:message])
      authorize @form.model
      @form.save do |form_data|
        receipt = current_user.send_message(
          form_data[:recipients],
          form_data[:body],
          form_data[:subject],
        )
        @message = receipt.message
      end
      flash[:success] = t('mailboxer.sent')
      redirect_to conversation_path(@message.conversation, :box => :sentbox)
    else
      render action: :new
    end
  end

  private

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end
end
