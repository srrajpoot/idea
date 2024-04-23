	class AddIdeasController < ApplicationController
	  skip_before_action :verify_authenticity_token


	  def create
      # byebug
      @add_idea = AddIdea.new(add_idea_params)

        if @add_idea.save
          render json: @add_idea, status: :created
        else
          render json: { error: @add_idea.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      def index
        # byebug
        @add_idea = AddIdea.all
        if @add_idea.present?
          render json: @add_idea, status: :ok
        else
          render json: { error: "No add_idea found"}, status: :not_found
        end
      end

      def show
        # byebug
        @add_idea = AddIdea.find_by(id: params[:id])
        if @add_idea.present?
          render json: @add_idea, status: :ok
        else
          render json: {error: "@add_idea not found"}, status: :not_found
        end
      end

      def destroy
        # byebug
        @add_idea = AddIdea.find_by(id: params[:id])
        if @add_idea.present?
          @add_idea.destroy
          render json: {messages: "idea has been deleted successfully"}, status: :ok
        else
          render json: {error: "idea not found"}, status: :not_found
        end
      end

      def update
        # byebug
        @add_idea = AddIdea.find_by(id: params[:id])
        if @add_idea.present?
          @add_idea.update(add_idea_params)
          render json: {messages: "idea has been update successfully"}, status: :ok
        else
          render json: {error: "idea not found"}, status: :not_found
        end
      end

      




      private

      def add_idea_params
        params.require(:add_idea).permit(:title, :idea_type, :account_id)
      end
  end 
