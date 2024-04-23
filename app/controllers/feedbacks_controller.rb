# class FeedbacksController < ApplicationController
#   before_action :set_current_user, only: :create
  # skip_before_action :verify_authenticity_token, only: [:create]

#   def create
#     @feedback = Feedback.new(feedback_params.merge(account_id: @current_user.id))
#     if @feedback.save
#       render json: FeedbackSerializer.new(@feedback).serializable_hash, status: :created
#     else
#       render json: { errors: format_activerecord_errors(@feedback.errors) }, status: :unprocessable_entity
#     end
#   end

#   private

#   def set_current_user
#     @current_user = find_current_user
#   end

# def find_current_user
#   token = request.headers['Authorization']
#   return nil unless token.present?

#   token_parts = token.split(' ')
#   return nil unless token_parts.length == 2 && token_parts.first == 'Bearer'

#   decoded_token = JWT.decode(token_parts.last, Rails.application.credentials.secret_key_base)
#   user_id = decoded_token.first['user_id']
#   Account.find_by(id: user_id)
# end

#   # def feedback_params
#   #   params.require(:feedback).permit(
#   #     :description,
#   #     context_attributes: [:id, :description, :url, :image, :video, :_destroy],
#   #     problem_attributes: [:id, :description, :url, :image, :video, :_destroy],
#   #     solution_attributes: [:id, :description, :url, :image, :video, :_destroy]
#   #   )
#   # end
#   def feedback_params
#   params.require(:feedback).permit(
#     :description,
#     context_attributes: [:id, :description, :url, :image, :video, :_destroy],
#     problem_attributes: [:id, :description, :url, :image, :video, :_destroy],
#     solution_attributes: [:id, :description, :url, :image, :video, :_destroy]
#   )
# end

# end



class FeedbacksController < ApplicationController
     skip_before_action :verify_authenticity_token, only: [:create]
  def create
    # byebug
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:description, :account_id)
  end
end

