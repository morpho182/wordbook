class CreateClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.references :word, foreign_key: true
      t.references :folder, foreign_key: true

      t.timestamps
      
      t.index [:word_id, :folder_id], unique: true
    end
  end
end
