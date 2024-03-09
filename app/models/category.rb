class Category < ApplicationRecord
  belongs_to :user
  has_many :category_bookmark, dependent: :destroy
  has_many :bookmarks, through: :category_bookmark

  validates :name, presence: true
end
