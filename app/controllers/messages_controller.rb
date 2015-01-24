class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_box, except: [:new]

  respond_to :html

  def show
    @message = Message.query {|m| m.find(params[:id]) }
    authorize @message
    redirect_to conversation_path(@message.conversation, box: box, anchor: "message_#{@message.id}")
  end

  def new
    @form = MessageForm.new(Message.new)
    if params[:receiver].present?
      receiver = User.query {|m| m.find(params[:receiver]) }
      @form.recipients = receiver.id
    end
    authorize @form.model
    @message = @form
  end

  def edit
  end

  def create
    @form = MessageForm.new(Message.new(sender: current_user))
    if @form.validate(params[:message])
      authorize @form.model
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

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end
end
