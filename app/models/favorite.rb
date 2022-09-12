class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :book, foreign_key: "book_id"

  validates :user_id, :uniqueness => { scope: :book_id }
end
