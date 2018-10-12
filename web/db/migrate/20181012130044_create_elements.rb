class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.references :category, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
