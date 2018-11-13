class User < ApplicationRecord
  # email最大255文字，password最低6文字のユーザー情報
  has_and_belongs_to_many :elements, :join_table => 'elements_users'
  accepts_nested_attributes_for :elements, allow_destroy: true
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships


  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 現在のユーザーがフォローされていたらtrueを返す
  def followed_by?(other_user)
    followers.include?(other_user)
  end

  # 現在のユーザーと相互フォローの場合trueを返す
  def friend?(other_user)
    following?(other_user) and followed_by?(other_user)
  end

  # 現在のユーザーのフレンドを返す
  def find_friends
    friends = []
    following.each do |user|
      friends << user if friend?(user)
    end
    return friends
  end

  # 現在のユーザーのフレンドリクエスト中ユーザーを返す
  def find_friend_requests
    follow_requests = []
    following.each do |user|
      follow_requests << user unless friend?(user)
    end
    return follow_requests
  end
end

