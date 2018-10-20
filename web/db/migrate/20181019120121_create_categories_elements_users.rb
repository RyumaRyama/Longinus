class CreateCategoriesElementsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :elements_users, id: false do |t|
      t.references :element, null: false
      t.references :user, null: false
    end
  end
end
