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

      flash[:success] = t('model.transaction.message.delete_success')
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
    group_id = params[:group_id].to_i
    from_date = to_date(params[:from_date]) unless params[:from_date].nil?
    to_date = to_date(params[:to_date]) unless params[:to_date].nil?
    type_id = params[:type_id] ? params[:type_id].to_i : 0
    category_id = params[:category_id] ? params[:category_id].to_i : 0

    @transactions = Transaction.includes(:user).by_group(group_id)
                                              .by_category(category_id)
                                              .by_type(type_id)
                                              .by_date(from_date, to_date)
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

    @current_money = Group.find_by_id(group_id).saved_money
    @categories = get_select_categories true, false
    
    types = {t("common.form.all_selection") => 0}
    @types_search = types.merge!(Transaction.type_ids)
    @categories_search = get_select_categories true, true
  end
end
