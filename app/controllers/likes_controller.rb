class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    byebug
    @like = Like.new(like_params)

    if @like.save
      render json: @like, status: :created
    else
      render json: { errors: @like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def like_params
    params.require(:like).permit(:like_by_id, :likeable_type, :likeable_id)
  end
end
