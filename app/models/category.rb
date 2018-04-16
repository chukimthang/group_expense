class Category < ApplicationRecord
  PAGE_SIZE = 10

  has_many :products
  has_many :expenses

  validates :name, presence: true, length: {maximum: 100}, uniqueness: true
end
