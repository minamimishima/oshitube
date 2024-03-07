class CategoryBookmark < ApplicationRecord
  belongs_to :category
  belongs_to :bookmark
end
