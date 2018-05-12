class Transaction < ApplicationRecord
  belongs_to :group
  belongs_to :user
  # belongs_to :category

  enum type_id: {
    Expense: 1,
    Income: 2
  }

  scope :by_group, -> (group_id){ where(group_id: group_id) }
  scope :by_category, ->(category_id){ category_id > 0 ? where(category_id: category_id) : all }
  scope :by_type, ->(type_id){ type_id > 0 ? where(type_id: type_id) : all }
  scope :by_date, ->(from_date, to_date){ 
    if from_date.blank? && to_date.blank?
      all
    else 
      where("DATE_FORMAT(updated_at, '%Y-%m-%d') >= '#{from_date}' AND DATE_FORMAT(updated_at, '%Y-%m-%d') <= '#{to_date}'") 
    end
  }
end
