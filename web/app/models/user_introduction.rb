class UserIntroduction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :element

  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :element_id, presence: true
end
