class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :follows, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def already_favorited?(book)
    self.favorites.exists?(book_id: book.id)
  end

  def followed_by?(user)
    passive_relationships.where(following_id: user.id).exists?
  end

  attachment :profile_image

  validates :name,
    presence:true,
    uniqueness: { case_sensitive: :false },
    length: { minimum: 2, maximum: 20 }
  
  validates :introduction,
    length: { maximum: 50 }
end
