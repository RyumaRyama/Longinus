class CreateUserIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_introductions do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.references :element, foreign_key: true

      t.timestamps
    end
  end
end
