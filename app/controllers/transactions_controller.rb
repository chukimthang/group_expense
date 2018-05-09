class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.by_group(params[:group_id]).order("created_at desc")
  end
end
