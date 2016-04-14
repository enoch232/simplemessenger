class ConversationsController < ApplicationController
  def index
  	@conversations = Conversation.all
  end

  def new
  end
end
