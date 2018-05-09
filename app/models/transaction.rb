class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :category

  enum type_id: {
    Expense: 1,
    Income: 2
  }

  scope :by_group, -> (group_id){ where(group_id: group_id) }
end
