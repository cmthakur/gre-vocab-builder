class AddSynonymsToWords < ActiveRecord::Migration
  def change
    add_column :words, :synonyms, :string
  end
end
