class CreateCategoriesElementsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_elements_users, id: false do |t|
      t.references :category, null: false
      # t.references :element, null: false
      t.references :user, null: false
    end
  end
end
