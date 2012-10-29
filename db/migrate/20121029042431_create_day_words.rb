class CreateDayWords < ActiveRecord::Migration
  def change
    create_table :day_words do |t|
      t.integer :word_id
      t.integer :day

      t.timestamps
    end

    add_index :day_words, :day, unique: true
  end
end
