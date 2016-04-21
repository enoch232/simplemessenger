class AddMessageCountToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :message_count, :integer
  end
end
