class Api::CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authenticate_user!


  def index
    @comments = Comment.where(user_id: current_user.id).order(created_at: :desc)
    render json: @comments, status: :ok
  end

  def index_post
    @comments = Comment.where(image_id: params[:image_id]).order(created_at: :desc)
    render json: @comments, status: :ok
  end

  def create
    @comment = Comment.create_comment(create_comment_params, current_user)
    render json: @comment, status: :ok
  end

  def update
    if (@comment.user == current_user)
      @comment.update(update_comment_params)
    end
    render json: @comment, status: :ok
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  def show
    render json: @comment, status: :ok
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def create_comment_params
    params.permit(:text, :image_id, :comment_id)
  end

  def update_comment_params
    params.permit(:text)
  end
end
