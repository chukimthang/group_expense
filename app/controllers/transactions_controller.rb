require 'rubyXL'
require 'fileutils'

class TransactionsController < ApplicationController
  include CommonHelper

  before_action :find_transaction, only: [:update, :destroy, :get_transaction_ajax]

  def index
    get_list_data
  end

  def create
    @transaction = Transaction.new transaction_params
  
    if @transaction.save
      if @transaction.type_id == "Expense"
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money - @transaction.amount
        group.save!
      else
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money + @transaction.amount
        group.save!
      end

      # get_list_data      
      # render template: "transactions/_list", layout: false

      flash[:success] = t('model.transaction.message.add_success')
      msg = {:status => "true", :transaction => @transaction}

      respond_to do |format|
        format.json {render :json => msg}
      end     
    end
  end

  def update
    amount_old = @transaction.amount
    
    if @transaction.update transaction_params
      if @transaction.type_id == "Expense"
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money + amount_old - @transaction.amount
        group.save!
      else
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money - amount_old + @transaction.amount
        group.save!
      end

      # get_list_data
      # render template: "transactions/_list", layout: false

      flash[:success] = t('model.transaction.message.update_success')
      msg = {:status => "true", :transaction => @transaction}

      respond_to do |format|
        format.json {render :json => msg}
      end    
    end
  end

  def destroy
    if @transaction.delete
      if @transaction.type_id == "Expense"
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money + @transaction.amount
        group.save!
      else
        group = Group.find_by_id @transaction.group_id
        group.saved_money = group.saved_money - @transaction.amount
        group.save!
      end

      # get_list_data
      # render template: "transactions/_list", layout: false

      flash[:success] = t('model.transaction.message.deleted_success')
      msg = {:status => "true", :transaction => @transaction}

      respond_to do |format|
        format.json {render :json => msg}
      end        
    end
  end

  def get_transaction_ajax
    respond_to do |format|
      format.json {render :json => @transaction}
    end
  end

  def export
    get_search_paramn

    @transactions = Transaction.includes(:user).by_group(@group_id)
                                              .by_category(@category_id)
                                              .by_type(@type_id)
                                              .by_date(@from_date, @to_date)
                                              .order("updated_at desc")

    file_path_template = "#{Rails.root.to_s}/files/templates/transaction.xlsx"
    template = RubyXL::Parser.parse(file_path_template)

    #Parse file from template
    workbook = RubyXL::Parser.parse_buffer(template.stream.string)
    worksheet = workbook[0]
    template.worksheets.delete(template[0])

    row_index = 4
    count = 1
    if @transactions.any?
      @transactions.each do |transaction|
        fill_data_row worksheet, row_index, transaction, count
        row_index += 1
        count += 1
      end
    end

    (1..6).each do |col|
      worksheet.change_column_horizontal_alignment(0, 'left')   
    end

    export_file_name = "transaction_#{DateTime.now.strftime(FORMAT_DATE_FILE)}.xlsx"
    dir = "#{Rails.root.to_s}/tmp/files/export"
    FileUtils::mkdir_p(dir) unless Dir.exists?(dir) # check folder exists
    file_path_temp = "#{dir}/#{export_file_name}"

    workbook.write(file_path_temp)
   
    send_file file_path_temp, :type => "application/excel", :x_sendfile => true
  end

  private
  def transaction_params
    if params[:transaction][:type_id].to_i == 2
      params[:transaction][:category_id] = 0
    end
    params[:transaction][:type_id] = params[:transaction][:type_id].to_i
    params[:transaction][:group_id] = params[:group_id].to_i
    params[:transaction][:user_id] = current_user.id

    params.require(:transaction).permit(:amount, :description, 
      :category_id, :group_id, :type_id, :user_id)
  end

  def find_transaction
    @transaction = Transaction.find_by_id params[:id].to_i

    if @transaction.nil?
      flash[:danger] = t "model.transaction.message.not_found"

      redirect_to group_transactions_url
    end
  end

  def get_list_data
    get_search_paramn

    @transactions = Transaction.includes(:user).by_group(@group_id)
                                              .by_category(@category_id)
                                              .by_type(@type_id)
                                              .by_date(@from_date, @to_date)
                                              .order("updated_at desc")


    @summary_income = 0
    @summary_expense = 0
  
    @transactions.each do |transaction|
      if transaction.type_id == "Expense"
        @summary_expense += transaction.amount
      else
        @summary_income += transaction.amount
      end
    end
    @summary_saved = @summary_income - @summary_expense

    @current_money = Group.find_by_id(@group_id).saved_money
    @categories = get_select_categories true, false
    
    types = {t("common.form.all_selection") => 0}
    @types_search = types.merge!(Transaction.type_ids)
    @categories_search = get_select_categories true, true
  end

  def get_search_paramn
    @group_id = params[:group_id].to_i
    @from_date = to_date(params[:from_date]) unless params[:from_date].nil?
    @to_date = to_date(params[:to_date]) unless params[:to_date].nil?
    @type_id = params[:type_id] ? params[:type_id].to_i : 0
    @category_id = params[:category_id] ? params[:category_id].to_i : 0
  end

  def fill_data_row worksheet, row_index, transaction, count
    worksheet.add_cell(row_index, 1, count)
    add_border_to_cell worksheet, row_index, 1

    worksheet.add_cell(row_index, 2, transaction.updated_at.strftime("%m/%d/%Y"))
    add_border_to_cell worksheet, row_index, 2

    worksheet.add_cell(row_index, 3, transaction.amount)
    add_border_to_cell worksheet, row_index, 3

    worksheet.add_cell(row_index, 4, transaction.description)
    add_border_to_cell worksheet, row_index, 4

    worksheet.add_cell(row_index, 5, transaction.user.full_name)
    add_border_to_cell worksheet, row_index, 5

    worksheet.add_cell(row_index, 6, transaction.type_id)
    add_border_to_cell worksheet, row_index, 6
  end

  def add_border_to_cell sheet, row, col
    sheet.sheet_data[row][col].change_border(:bottom, 'thin')
    sheet.sheet_data[row][col].change_border(:left, 'thin')
    if col == 6
      sheet.sheet_data[row][col].change_border(:right, 'thin')
    end
  end
end
