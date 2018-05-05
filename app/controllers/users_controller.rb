class UsersController < ApplicationController
  include CommonHelper

  before_action :find_user, only: :destroy

  def index
    per_page = params[:per_page] ? params[:per_page].to_i : User::PAGE_SIZE
    page_index = 1

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    email = params[:search_email] unless params[:search_email].nil?
    is_deleted = params[:search_is_deleted] ? params[:search_is_deleted] : nil
    @sort_name = params[:sort_name] ? params[:sort_name] : "email"
    @sort_by = params[:sort_by] ? params[:sort_by] : "asc"

    @users = User.by_default(email, is_deleted).by_email(email).by_is_deleted(is_deleted)
                  .page(page_index).per(per_page)
                  .order("#{@sort_name} #{@sort_by}")
   
    @total_records = @users.size

    @start_count = 1
    if page_index > 1
      @start_count = per_page * (page_index - 1) + 1
    end

    @status_user = [[t("common.form.all_selection"), nil], [t("common.actived"), 0], [t("common.inactived"), 1]]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
   
    if @user.save
      flash[:success] = t("model.user.message.add_success")

      redirect_to users_url    
    else
      render :new
    end
  end

  def destroy
    if @user.is_deleted
      @user.update(is_deleted: false)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "false"}}
      end
    else
      @user.update(is_deleted: true)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "true"}}
      end
    end
  end

  def ckeck_user_exists_ajax
    user_count = User.where(email: params[:fieldValue]).count

    if user_count > 0
      render :json => ["user_email", false]
    else
      render :json => ["user_email", true]
    end
  end

  private
  def find_user
    @user = User.find_by_id params[:id]

    if @user.nil?
      flash[:danger] = t "model.user.message.not_found"

      redirect_to users_url
    end
  end

  def user_params
    params[:user][:birthday] = to_date(params[:user][:birthday])
    
    params.require(:user).permit(:email, :password, :password_confirmation, 
      :is_admin, :full_name, :birthday, :description)
  end
end
