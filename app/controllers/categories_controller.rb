class CategoriesController < ApplicationController
  load_and_authorize_resource
  before_action :find_category, only: [:update, :destroy, :get_category_ajax]

  def index
    per_page = params[:per_page] ? params[:per_page].to_i : Category::PAGE_SIZE
    page_index = 1

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    @categories = Category.page(page_index).per(per_page)
    @total_records = @categories.size

    @start_count = 1
    if page_index > 1
      @start_count = per_page * (page_index - 1) + 1
    end
  end

  def create
    @category = Category.new category_params
   
    if @category.save
      flash[:success] = t 'model.category.message.add_success'
      msg = {:status => "true", :category => @category}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @category.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def update
    if @category.update category_params
      flash[:success] = t 'model.category.message.update_success'
      msg = {:status => "true", :category => @category}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @category.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def destroy
    count_category_in_expense = Transaction.where(category_id: @category.id).count
    count_category_in_product = Product.where(category_id: @category.id).count

    if count_category_in_expense == 0 && count_category_in_product == 0
      @category.delete
      flash[:success] = t 'model.category.message.deleted_success'

      respond_to do |format|
        format.html { redirect_to group_categories_path }
      end
    else
      flash[:danger] = t "common.not_delete"

      respond_to do |format|
        format.html { redirect_to group_categories_path }
      end
    end
  end

  def get_category_ajax
    respond_to do |format|
      format.json {render :json => @category}
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find_by_id params[:id]

    if @category.nil?
      flash[:success] = t 'model.category.message.not_found'

      redirect_to group_categories_path
    end
  end
end
