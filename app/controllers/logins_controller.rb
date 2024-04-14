class LoginsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # byebug
    email = params[:data][:attributes][:email].downcase
    password = params[:data][:attributes][:password]

    account = Account.find_by(email: email)

    if account.present? && account.password == password
      token = encode(account.id)
      # token = Account.encode(account.id)
      # token = AccountsController.new.encode(account.id)


      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
  private

  def encode(id)
    # byebug
    JsonWebToken.encode id
  end
end

