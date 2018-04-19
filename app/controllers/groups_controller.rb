class GroupsController < ApplicationController
  before_action :find_group, only: [:update, :destroy, :get_group_ajax, :post_group_blocked_ajax]

  def create
    @group = Group.new group_params
  
    if @group.save
      flash[:success] = t "model.group.message.add_success"
      msg = {:status => "true", :group => @group}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @group.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def update
    if @group.update group_params
      flash[:success] = t "model.group.message.update_success"
      msg = {:status => "true", :group => @group}

      respond_to do |format|
        format.json {render :json => msg}
      end
    else
      @errors = @group.errors.messages
      msg = {:status => "false", :errors => @errors}

      respond_to do |format|
        format.json {render :json => msg}
      end
    end
  end

  def destroy
    count_income = Income.where(is_deleted: false, group_id: @group.id).count
    count_expense = Expense.where(is_deleted: false, group_id: @group.id).count
    count_product = Product.where(group_id: @group.id).count
    count_user_group = UserGroup.where(group_id: @group.id).count

    if count_income == 0 && count_expense == 0 && count_product == 0 && count_user_group == 0
      @group.delete
      flash[:success] = t "model.group.message.deleted_success"

      respond_to do |format|
        format.html { redirect_to root_path }
      end
    else
      flash[:danger] = t "view.message.not_delete"

      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  def get_group_ajax
    respond_to do |format|
      format.json {render :json => @group}
    end
  end

  def post_group_blocked_ajax
    if @group.is_deleted
      @group.update(is_deleted: false)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "false"}}
      end
    else
      @group.update(is_deleted: true)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "true"}}
      end
    end
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end

  def find_group
    @group = Group.find_by_id params[:id]

    if @group.nil?
      flash[:danger] = t "model.group.message.not_found"

      redirect_to root_url
    end
  end
end
