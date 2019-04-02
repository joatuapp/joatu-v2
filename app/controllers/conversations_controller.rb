class ConversationsController < ApplicationController

  before_action :authenticate_user!
  before_action :get_box
  before_action :get_conversation, only: [:show, :update, :destroy]

  # We look up conversations by user, no need to scope it too.
  skip_after_action :verify_policy_scoped, only: :index

  respond_to :html

  def index
    get_conversations
    respond_with(@conversations)
  end

  def show
    get_conversations
    @reply = MessageForm.new(Message.new)
    @messages = @conversation.read_messages_for_user_and_box!(current_user, @box)
    authorize @conversation
    respond_with(@conversation)
  end

  def update
    authorize @conversation
    if params[:untrash].present?
      @conversation.untrash(current_user)
    end
    
    if params[:reply_all].present?
      @form = MessageForm.new(Message.new)
      if @form.validate(params[:message])
        @form.save do |message_data|
          @receipt = @conversation.reply_to_all(current_user, message_data[:body])
        end
        @messages = @conversation.read_messages_for_user_and_box!(current_user, @box)
        redirect_to action: :show
      else
        @messages = @conversation.read_messages_for_user_and_box!(current_user, @box)
        @reply = @form
        render :show
      end
    end

  end

  def destroy
    authorize @conversation
    @conversation.move_to_trash(current_user)

    if params[:location].present? and params[:location] == 'conversation'
      redirect_to conversations_path(:box => :trash)
    else
      redirect_to conversations_path(:box => @box, :conversations_page => params[:conversations_page])
    end
  end

  private

  def get_conversations
    @conversations = Conversation.send("user_#{@box}", current_user, PaginationOptions.new(params[:conversations_page]))
  end

  def get_conversation
    @conversation = Conversation.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sentbox","trash"].include?params[:box]
      params[:box] = 'inbox'
    end

    @box = params[:box]
  end
end
