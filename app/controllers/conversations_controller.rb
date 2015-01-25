class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box

  # We look up conversations by user, no need to scope it too.
  skip_after_filter :verify_policy_scoped, only: :index

  respond_to :html

  def index
    @conversations = Conversation.query {|m| m.user_conversations(current_user, @box).page(params[:page]) }
    respond_with(@conversations)
  end

  def show
    @reply = MessageForm.new(Message.new)
    @conversation = Conversation.query {|m| m.find(params[:id]) }
    @messages = @conversation.read_messages_for_user_and_box!(current_user, @box)
    authorize @conversation
    respond_with(@conversation)
  end

  def update
    @conversation = Conversation.query {|m| m.find_by_id(params[:id]) }
    authorize @conversation
    if params[:untrash].present?
      @conversation.untrash(current_user)
    end
    
    if params[:reply_all].present?
      @receipt = @conversation.reply_to_all(current_user, params[:message][:body])
    end

    @messages = @conversation.read_messages_for_user_and_box!(current_user, @box)
    redirect_to action: :show
  end

  def destroy
    @conversation = Conversation.query {|m| m.find(params[:id]) }
    authorize @conversation
    @conversation.destroy!(current_user)

    if params[:location].present? and params[:location] == 'conversation'
      redirect_to conversations_path(:box => :trash)
    else
      redirect_to conversations_path(:box => @box,:page => params[:page])
    end
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
