class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :receiver_id
      t.integer :sender_id

      t.timestamps null: false
    end
  end
end
