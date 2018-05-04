class Product < ApplicationRecord
  PAGE_SIZE = 10
  
  belongs_to :category
  # belongs_to :group

  scope :by_group, ->(group_id){ group_id > 0 ? where("is_shared = true OR group_id = #{group_id}") : all  }
  scope :by_name, ->(name){ name.blank? ? all : where("name LIKE '%#{name}%'") }
  scope :by_category, ->(category_id){ category_id > 0 ? where(category_id: category_id) : all }
end
