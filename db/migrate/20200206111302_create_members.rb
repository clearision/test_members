class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :url
      t.string :short_url
      t.text :headings

      t.timestamps
    end

    add_index :members, :name, unique: true
  end
end
