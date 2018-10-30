class CreateElements < ActiveRecord::Migration[5.2]
  def change
    create_table :elements do |t|
      t.string :name

      t.timestamps
    end

    drop_table :elements
  end
end
