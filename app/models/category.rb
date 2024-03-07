class Category < ApplicationRecord
  belongs_to :user
  has_many :category_bookmark
  has_many :bookmarks, through: :category_bookmark
end
