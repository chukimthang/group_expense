class DataFile < ApplicationRecord
  belongs_to :user
  belongs_to :group

  enum type_action_id: {
    Export: 1,
    Import: 2
  }

  scope :by_group, -> (group_id){group_id > 0 ? where(group_id: group_id) : all }
  scope :by_user, -> (user_id){ user_id > 0 ? where(user_id: user_id) : all }
  scope :by_type_action, ->(type_action_id){ type_action_id > 0 ? where(type_action_id: type_action_id) : all }
  scope :by_date, ->(from_date, to_date){ 
    from_date.blank? && to_date.blank? ? all : where(created_at: from_date..to_date + 1.day - 1.second)
  }
end
