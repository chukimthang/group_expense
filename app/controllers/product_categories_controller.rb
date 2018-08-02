class ProductCategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @product_categories = ProductCategory.where(parent_id: nil)
    @total_records = ProductCategory.count
  end
end
