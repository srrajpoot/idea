class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update, :destroy]
    # skip_before_action :verify_authenticity_token, only: [:create]
      skip_before_action :set_address



    def create
    	byebug
	    @address = Address.new(address_params)

	    if @address.save
	      render json: { address: @address, message: 'Address created successfully' }, status: :created
	    else
	      render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
	    end
	  end

	  private

	  def address_params
	    params.require(:address).permit(:country, :latitude, :longitude, :address, :addressble_id, :addressble_type, :address_type)
	end








  # # PATCH/PUT /addresses/1
  # def update
  #   if @address.update(address_params)
  #     render json: { address: @address, message: 'Address Updated Successfully' }
  #   else
  #     render json: { errors: @address.errors }, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /addresses/1
  # def destroy
  #   @address.destroy
  #   head :no_content
  # end

  # private
  #   def set_address
  #     @address = Address.find(params[:id])
  #   end

  #   def address_params
  #     params.require(:address).permit(:country, :latitude, :longitude, :address, :addressble_id, :addressble_type, :address_type)
  #   end
end
