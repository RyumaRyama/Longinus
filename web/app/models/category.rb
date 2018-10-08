class Category < ApplicationRecord
  has_many :elements
  validates :name, presence: true, length: { maximum: 10 }
end
