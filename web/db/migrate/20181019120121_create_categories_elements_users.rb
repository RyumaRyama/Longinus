class CreateCategoriesElementsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_users, id: false do |t|
      t.references :category, null: false
      t.references :user, null: false
    end
  end
end
