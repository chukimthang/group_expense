class ProductCategory < ApplicationRecord
  has_many :children, class_name: 'ProductCategory', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'ProductCategory', foreign_key: 'parent_id'

  def get_ancestors(level = 0, result = [])
    result.push([level, self])
    if(!self.children.empty?)
      self.children.each do |child|
        child.get_ancestors(level + 1, result)
      end
    end

    if(level == 0)
      return result
    end
  end
end
