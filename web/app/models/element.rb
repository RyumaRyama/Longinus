class Element < ApplicationRecord
  # has_and_belongs_to_manyではprivate設定の実現が難しいのでは
  has_and_belongs_to_many :users, :join_table => 'elements_users'
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
