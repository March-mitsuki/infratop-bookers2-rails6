class Book < ApplicationRecord
  # f_key
  belongs_to :user, foreign_key: "user_id"

  has_many :favorites, foreign_key: "book_id", dependent: :destroy
  has_many :book_comments, foreign_key: "book_id", dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {
      maximum: 200
  }

  def favorited_by?(user)
      favorites.exists?(user_id: user.id)
  end
end
