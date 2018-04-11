class Category < ApplicationRecord
  PAGE_SIZE = 10

  validates :name, presence: true, length: {maximum: 100}, uniqueness: true
end
