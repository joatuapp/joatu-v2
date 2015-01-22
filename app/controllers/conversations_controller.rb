class ConversationsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_mailbox, :get_box
  skip_after_filter :verify_policy_scoped, only: :index

  respond_to :html

  def index
    @conversations = @mailbox.send(@box).page(params[:page])
    respond_with(@conversations)
  end

  def show
    @conversation = Mailboxer::Conversation.find_by_id(params[:id])
    authorize @conversation
    if @box == 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end
    respond_with(@conversation)
    @receipts.mark_as_read
  end

  def update
    @conversation = Conversation.find_by_id(params[:id])
    authorize @conversation
    if params[:untrash].present?
      @conversation.untrash(current_user)
    end
    
    if params[:reply_all].present?
      last_receipt = @mailbox.recipts_for(@conversation).last
      @receipt = current_user.reply_to_all(last_receipt, params[:body])
    end

    if @box == 'trash'
      @receipts = @mailbox.receipts_for(@conversation).trash
    else
      @receipts = @mailbox.receipts_for(@conversation).not_trash
    end

    redirect_to action: :show
    @receipts.mark_as_read
  end

  def destroy
    @conversation = Conversation.find_by_id(params[:id])
    authorize @conversation
    @conversation.move_to_trash(current_user)

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
