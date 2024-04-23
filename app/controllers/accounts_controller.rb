class AccountsController < ApplicationController
  include JsonWebTokenValidation


  # before_action :validate_json_web_token, only: :search
  skip_before_action :verify_authenticity_token, only: [:create,:destroy]
  before_action :authenticate_user, only: [:change_email, :change_password]



def create
  # byebug
  account = Account.new(email: params[:data][:attributes][:email].downcase, password: params[:data][:attributes][:password])
  if account.save
    # byebug
      token = encode(account.id)
      # token = Account.encode(account.id)
      

      render json: { token: token }, status: :ok

  else
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end
end

def index
  # byebug
  accounts = Account.all
  if accounts.any?
    render json: accounts, status: :ok
  else
    render json: { error: 'No accounts found' }, status: :not_found
  end
end


def show
  byebug
  account = Account.find_by(id: params[:id])
  if account.present?
    render json: account, status: :ok
  else
    render json: { error: 'Account not found' }, status: :not_found
  end
end


  def destroy
    # byebug
    account = Account.find_by(id: params[:id])
    if account.present?
      account.destroy
      render json: { message: 'Account deleted successfully' }, status: :ok
    else
      render json: { error: 'Account not found' }, status: :not_found
    end
  end


  def change_email
    byebug
    account = current_user
    new_email = params[:email].downcase

    if account.update(email: new_email)
      render json: { message: 'Email updated successfully' }, status: :ok
    else
      render json: { error: 'Failed to update email' }, status: :unprocessable_entity
    end
  end


   def change_password
    byebug
    account = current_user
    new_password = params[:password]

    if account.update(password: new_password)
      render json: { message: 'Password updated successfully' }, status: :ok
    else
      render json: { error: 'Failed to update password' }, status: :unprocessable_entity
    end
  end


 def forget_password
  byebug
    email = params[:email]
    account = Account.find_by(email: email.downcase)

    if account
      # Implement logic to send a password reset email
      render json: { message: 'Password reset instructions sent to your email' }, status: :ok
    else
      render json: { error: 'Email not found' }, status: :not_found
    end
  end




  private

  def encode(id)
    # byebug
    JsonWebToken.encode id
  end
  
  # def format_activerecord_errors(errors)
  #   result = []
  #   errors.each do |attribute, error|
  #     result << { attribute => error }
  #   end
  #   result
  # end


  def current_user
    @current_user
  end
end
