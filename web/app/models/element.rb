class Element < ApplicationRecord
  # has_and_belongs_to_manyではprivate設定の実現が難しいのでは
  has_many :users_elements
  has_many :users, through: :users_elements

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
