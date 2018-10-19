class Element < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :users, :join_table => 'categories_elements_users'
  # has_many :user_introductions
  validates :category_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
