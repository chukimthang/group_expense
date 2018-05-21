require 'json'

class DataFilesController < ApplicationController
  include CommonHelper

  before_action :find_data_file, only: [:destroy, :download]

  def index
    data_list
  end

  def destroy
    begin
      path_to_file = "#{Rails.root}#{@data_file.file_path}"
      File.delete(path_to_file) if File.exist?(path_to_file)
      @data_file.delete
      flash[:success] = t("model.data_file.message.deleted_success")

      redirect_to data_files_path
    rescue
    end
  end

  def download
    path_to_file = "#{Rails.root}#{@data_file.file_path}"
    exist_file = File.exist?(path_to_file)

    if exist_file
      send_file(
        path_to_file,
        filename: "#{@data_file.file_name}",
        type: "application/excel"
      )
    else
      respond_to do |format|
        flash[:danger] = t "model.data_file.message.path_not_found"
        format.html {redirect_to data_files_url}
      end
    end
  end

  def destroy_multi
    unless params[:data_file_ids].nil?
      data_file_ids = JSON.parse(params[:data_file_ids])
      # DataFile.where(:id => data_file_ids).destroy_all
      
      data_file_ids.each do |data_file_id|
        data_file = DataFile.find_by_id data_file_id
        path_to_file = "#{Rails.root}#{data_file.file_path}"
        File.delete(path_to_file) if File.exist?(path_to_file)
        data_file.delete
      end

      flash[:success] = t("model.data_file.message.deleted_success")

      respond_to do |format|
        format.json {render :json => {:status => "true"}}
      end
    end
  end

  private
  def find_data_file
    @data_file = DataFile.find_by_id params[:id]

    if @data_file.nil?
      flash[:danger] = t "model.data_file.message.not_found"

      redirect_to data_files_path
    end
  end

  def form_params
    types = {t("common.form.all_selection") => 0}
    @type_actions_search = types.merge!(DataFile.type_action_ids)

    @groups = get_select_groups true, true
    @users = get_select_users true, true
  end

  def search_params
    @group_id = params[:group_file_id].to_i
    @from_date = to_date(params[:from_date]) unless params[:from_date].nil?
    @to_date = to_date(params[:to_date]) unless params[:to_date].nil?
    @type_action_id = params[:type_action_id] ? params[:type_action_id].to_i : 0
    @user_id = params[:user_id] ? params[:user_id].to_i : 0
  end

  def data_list
    search_params
    @data_files = DataFile.includes(:user).includes(:group)
                                          .by_group(@group_id)
                                          .by_type_action(@type_action_id)
                                          .by_user(@user_id)
                                          .by_date(@from_date, @to_date)
                                          .order(created_at: :desc)
    form_params
  end
end
