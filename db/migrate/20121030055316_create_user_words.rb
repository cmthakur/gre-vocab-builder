class CreateUserWords < ActiveRecord::Migration
  def change
    create_table :user_words do |t|
      t.integer :user_id
      t.integer :word_id
      t.integer :score

      t.timestamps
    end

    add_index :user_words, :user_id
    add_index :user_words, :word_id
  end
end
