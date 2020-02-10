class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :friend_id
      t.integer :member_id

      t.timestamps
    end

    add_index :friendships, [:friend_id, :member_id], unique: true
  end
end
