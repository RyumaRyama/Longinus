class Element < ApplicationRecord
  belongs_to :category
  has_many :user_introductions
  validates :category_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }, uniqueness: true
end
