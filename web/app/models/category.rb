class Category < ApplicationRecord
  has_many :elements
  # has_many :user_introductions
  # has_and_belongs_to_many :elements
  validates :name, presence: true, length: { maximum: 10 }, uniqueness: true
end
