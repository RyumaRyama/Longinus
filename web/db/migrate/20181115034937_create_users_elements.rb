class CreateUsersElements < ActiveRecord::Migration[5.2]
  def change
    create_table :users_elements do |t|
      t.belongs_to :user
      t.belongs_to :element
      t.string :private

      t.timestamps
    end
  end
end
