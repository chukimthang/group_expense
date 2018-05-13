class HomeController < ApplicationController
  def index
    per_page = params[:per_page] ? params[:per_page].to_i : Group::PAGE_SIZE
    page_index = 1

    unless params[:page].nil?
      page_index = params[:page].to_i
    end

    user_groups = UserGroup.where(user_id: current_user.id)
    group_ids = []
    user_groups.each do |user_group|
      unless group_ids.include? user_group.group_id
        group_ids << user_group.group_id
      end
    end

    unless group_ids.empty?
      group_ids = group_ids.join(',')
      
      @groups = Group.where("id IN(#{group_ids})").page(page_index).per(per_page)
      @total_records = @groups.size

      @start_count = 1
      if page_index > 1
        @start_count = per_page * (page_index - 1) + 1
      end
    else
      @groups = []
    end
  end

  def set_locale
    session[:locale] = params[:locale]
    redirect_to :back
  end
end
