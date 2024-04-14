class AccountsController < ApplicationController
  include JsonWebTokenValidation


  # before_action :validate_json_web_token, only: :search
  skip_before_action :verify_authenticity_token, only: [:create]



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



# https://guacamole.bxidecp1.prod.ap-south-1.aws.svc.builder.ai/guacamole/#/?accessToken=1a0512133649062cf8df




  private

  def encode(id)
    # byebug
    JsonWebToken.encode id
  end
  
  def format_activerecord_errors(errors)
    result = []
    errors.each do |attribute, error|
      result << { attribute => error }
    end
    result
  end
end
