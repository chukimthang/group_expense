require 'json'

class GroupMembersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @group_members = GroupMember.includes(:group).includes(:user)
                                .where(group_id: params[:group_id])
    
    # url = "#{Rails.root.to_s}/app/services/cities.json"
    # @list_cities = File.read(url)

    @group_member = GroupMember.new
  end

  def create
    list_members = JSON.parse(params[:list_members_hidden])

    unless list_members.empty?
      list_members.each { |member|
        group_member = GroupMember.new
        group_member.user_id = member["id"]
        group_member.group_id = params[:group_id].to_i
        group_member.save
      }

      flash[:success] = t("model.group_member.message.add_success")

      respond_to do |format|
        format.html {
          redirect_to group_group_members_url
        }
      end
    end
  end

  def destroy
    @group_member = GroupMember.find_by_id params[:id]

    if @group_member.is_deleted
      @group_member.update(is_deleted: false)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "false"}}
      end
    else
      @group_member.update(is_deleted: true)

      respond_to do |format|
        format.json {render :json => {:status => "true", :is_deleted => "true"}}
      end
    end
  end
end
