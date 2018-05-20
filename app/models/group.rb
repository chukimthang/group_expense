class Group < ApplicationRecord
  PAGE_SIZE = 10

  has_many :group_members
  has_many :transactions
  has_many :data_files
end
