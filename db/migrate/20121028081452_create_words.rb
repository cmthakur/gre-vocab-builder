class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :lemma
      t.text :definition
      t.boolean :high_frequency
      t.text :images
      t.integer :wordnet_id

      t.timestamps
    end

    add_index :words, :lemma, unique: true
  end
end
