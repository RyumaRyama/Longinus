class Category < ApplicationRecord
  has_many :elements
  has_many :user_introductions
  validates :name, presence: true, length: { maximum: 10 }, uniqueness: true
end
