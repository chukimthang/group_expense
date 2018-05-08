class Group < ApplicationRecord
  PAGE_SIZE = 10

  has_many :group_members
  # has_many :products
end
