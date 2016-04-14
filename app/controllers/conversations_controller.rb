class ConversationsController < ApplicationController
	before_action :authenticate_user!
  def index
  	@conversations = Conversation.all.where('sender_id=? OR receiver_id=?',current_user,current_user)
  end

  def new
  	@conversation = Conversation.new

  end
  def create
  	@conversation = Conversation.new
  	@conversation.receiver_id = User.all.where('email = ?', params[:receiver_email]).first.id
  	@conversation.sender_id = current_user.id
  	if @conversation.save
  		redirect_to root_path
  	else
  		render :new
  	end
  end
  private
  def conversation_params
  	#params.require(:conversation).permit(:receiver_id, :sender_id)
  end
end
