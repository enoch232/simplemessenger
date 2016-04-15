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
  	receiver= User.all.where('email = ?', params[:receiver_email]).first
  	
  	
  	if receiver
  		@conversation.receiver_id = receiver.id
	  	@conversation.sender_id = current_user.id
	  	if @conversation.save
	  		@conversation.messages.create!(text: params[:message])
	  		redirect_to root_path
	  	else
	  		render :new
	  	end
	else

		render :new , notice: "There is no user"
	end
  end
  def show
  	@conversation = Conversation.find(params[:id])
  end

  private
  def conversation_params
  	#params.require(:conversation).permit(:receiver_id, :sender_id)
  end
end
