MessageStruct = Struct.new(:recipients, :subject, :body) do
  def persisted? 
    false
  end
  def to_key
    ["foobar"]
  end
  def model_name
  end
end

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box
  skip_after_filter :verify_authorized, only: [:new, :create]

  respond_to :html

  def show
    @message = Message.find(params[:id])
    authorize @message
    redirect_to conversation_path(@message.conversation, box: box, anchor: "message_#{@message.id}")
  end

  def new
    if params[:receiver].present?
      @receipient = User.find(params[:receiver])
    end
    @message = MessageForm.new(MessageStruct.new)
  end

  def edit
  end

  def create
    @message = MessageForm.new(MessageStruct.new)
    if @message.validate(params[:message])
      @message.save do |message_data|
        @receipt = current_user.send_message(message_data[:recipients], message_data[:body], message_data[:subject])
        if (@receipt.errors.blank?)
          @conversation = @receipt.conversation
          flash[:success] = t('mailboxer.sent')
          return redirect_to conversation_path(@conversation, :box => :sentbox)
        end
      end
    end
    Rails.logger.debug @receipt.errors.inspect
    render action: :new
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
