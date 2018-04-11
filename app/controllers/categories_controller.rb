class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :destroy, :get_category_ajax]

  def index
    per_page = params[:per_page] ? params[:per_page].to_i : Category::PAGE_SIZE
    page_index = 1

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    @categories = Category.where(is_deleted: false).page(page_index).per(per_page)
    @total_records = @categories.size

    @start_count = 1
    if page_index > 1
      @start_count = per_page * (page_index - 1) + 1
    end
  end

  def create
    @category = Category.new category_params
    category_existed = Category.where(is_deleted: true, name: @category.name).first
    
    if category_existed
      category_existed.update(is_deleted: false)
      flash[:success] = t "view.message.add_success", resource: 'Category'

      redirect_to categories_url
    else
      if @category.save
        flash[:success] = t "view.message.add_success", resource: 'Category'
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
  end

  def update
    if @category.update category_params
      flash[:success] = t "view.message.update_success", resource: 'Category'
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
    count_category = Expense.where(is_deleted: false, category_id: @category.id).count
   
    if count_category == 0
      @category.update(is_deleted: true)
      flash[:success] = t "view.message.deleted_success", resource: 'Category'

      respond_to do |format|
        format.html { redirect_to categories_path }
      end
    else
      flash[:danger] = t "view.message.not_delete"

      respond_to do |format|
        format.html { redirect_to categories_path }
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
      flash[:danger] = t "view.message.not_found", resource: 'Category'

      redirect_to categories_url
    end
  end
end
