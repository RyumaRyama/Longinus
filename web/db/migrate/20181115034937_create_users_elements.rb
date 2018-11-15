class CreateUsersElements < ActiveRecord::Migration[5.2]
  def change
    create_table :users_elements do |t|
      t.belongs_to :user, index: true
      t.belongs_to :element, index: true
      t.boolean :private

      t.timestamps
    end
  end
end
