class ProductsController < ApplicationController
  include CommonHelper

  before_action :find_product, only: [:update, :destroy, :get_product_ajax]

  def index
    per_page = params[:per_page] ? params[:per_page].to_i : Product::PAGE_SIZE
    page_index = DEFAULT_PAGE_INDEX

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    unless params[:group_id].nil?
      group_id = params[:group_id].to_i
    end

    name = params[:search_name] unless params[:search_name].nil?
    category_id = params[:search_category_id] ? params[:search_category_id].to_i : 0

    @products = Product.includes(:category)
                      .by_group(group_id)
                      .by_name(name)
                      .by_category(category_id)
                      .order(category_id: :asc)
                      .page(page_index).per(per_page)

    if @products.any?
      @total_records = @products.size

      @start_count = 1
      if page_index > 1
        @start_count = per_page * (page_index - 1) + 1
      end

      @category_count_data = Hash.new(0)
      @products.each do |product|
        @category_count_data[product.category_id] += 1
      end
    else
      @total_records = 0
    end

    @categories = get_select_categories
    @categories_select = get_select_categories true
  end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t "model.product.message.add_success"
      msg = {:status => "true", :product => @product}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @product.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def update
    if @product.update product_params
      flash[:success] = t "model.product.message.update_success"
      msg = {:status => "true", :product => @product}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @product.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def destroy
    @product.delete
    flash[:success] = t "model.product.message.deleted_success"

    respond_to do |format|
      format.html { redirect_to group_products_path }
    end
  end

  def get_product_ajax
    respond_to do |format|
      format.json {render :json => @product}
    end
  end

  private
  def product_params
    if params[:product][:is_shared].to_i == 1
      params[:product][:group_id] = 0
    else
      params[:product][:group_id] = params[:group_id].to_i
    end

    params.require(:product).permit(:name, :category_id, :group_id, :is_shared)
  end

  def find_product
    @product = Product.find_by_id params[:id]

    if @product.nil?
      flash[:danger] = t "model.product.message.not_found"

      redirect_to group_products_url
    end
  end
end
