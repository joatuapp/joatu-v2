class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box
  skip_after_filter :verify_authorized, only: [:new, :create]

  respond_to :html

  def show
    @message = Message.query {|m| m.find(params[:id]) }
    authorize @message
    redirect_to conversation_path(@message.conversation, box: box, anchor: "message_#{@message.id}")
  end

  def new
    if params[:receiver].present?
      @receipient = User.query {|m| m.find(params[:receiver]) }
    end
    @message = MessageForm.new(Message.new)
  end

  def edit
  end

  def create
    @form = MessageForm.new(Message.new(nil, sender: current_user))
    if @form.validate(params[:message])
      @message = @form.save
      flash[:success] = t('mailboxer.sent')
      redirect_to conversation_path(@message.conversation, :box => :sentbox)
    else
      render action: :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def get_mailbox
    @mailbox = current_user.mailbox
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end
end
