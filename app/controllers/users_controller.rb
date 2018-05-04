class UsersController < ApplicationController
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

  private
  def find_user
    @user = User.find_by_id params[:id]

    if @user.nil?
      flash[:danger] = t "model.user.message.not_found"

      redirect_to users_url
    end
  end
end
