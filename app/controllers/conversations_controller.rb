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
  		if Conversation.all.where('(sender_id=? and receiver_id = ?) || (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).blank?

	  		@conversation.receiver_id = receiver.id
		  	@conversation.sender_id = current_user.id
		  	if @conversation.save
		  		@conversation.messages.create!(user_id: current_user.id, text: params[:message])
		  		redirect_to root_path
		  	else
		  		render :new
		  	end
		else
			@conversation = Conversation.all.where('(sender_id=? and receiver_id = ?) || (sender_id=? and receiver_id=?)',current_user,receiver ,receiver, current_user).first
			@conversation.messages.create!(user_id: current_user.id, text: params[:message])
			redirect_to @conversation
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
