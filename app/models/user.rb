class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # attache to active storage
  has_one_attached :profile_image

  # f_key
  has_many :books, foreign_key: "user_id", dependent: :destroy
  has_many :book_comments, foreign_key: "user_id", dependent: :destroy
  has_many :favorites, foreign_key: "user_id", dependent: :destroy
  has_many :follower, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :follower_users, through: :follower, source: :follower
  has_many :followed, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :followed, source: :followed

  # validates
  validates :name, uniqueness: true, length: { 
    minimum: 2, maximum: 20
  }
  validates :introduction, length: { 
    maximum: 50
  }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
