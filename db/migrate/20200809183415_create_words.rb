class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :word
      t.string :definition
      t.string :link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
