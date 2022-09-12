class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.integer :user_id
      t.integer :book_id
      t.string :comment

      t.timestamps
    end

    add_index :book_comments, :comment
  end
end
