class MessagesController < ApplicationController
	def new
	end
	def create
		
		@conversation = Conversation.find()
	end
	private
	def message_params
		params.require(:message).permit(:text)
	end
end
