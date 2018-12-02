class Element < ApplicationRecord
  # has_and_belongs_to_manyではprivate設定の実現が難しいのでは
  has_many :users_elements
  has_many :users, through: :users_elements

  accepts_nested_attributes_for :users_elements,:users, allow_destroy: true

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
