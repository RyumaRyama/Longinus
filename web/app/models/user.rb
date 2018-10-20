class User < ApplicationRecord
  # email最大255文字，password最低6文字のユーザー情報
  # has_many :user_introductions, dependent: :destroy
  has_and_belongs_to_many :categories, :join_table => 'categories_users'
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end

