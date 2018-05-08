class GroupMember < ApplicationRecord
  self.table_name = "user_groups"

  belongs_to :group
  belongs_to :user
end
