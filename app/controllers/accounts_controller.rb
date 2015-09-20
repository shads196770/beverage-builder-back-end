class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :update, :destroy]

  def index
    @accounts = Account.all

    render json: @accounts
  end

  def show
    render json: @account
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :internal_server_error
    end
  end

  def update
    if @account.update(account_params)
      head :no_content
    else
      render json: @account.errors, status: :internal_server_error
    end
  end

  def destroy
    if @account.destroy
      head :no_content
    else
      render json: @account.errors, status: :internal_server_error
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:id, :email, :password)
  end
end
