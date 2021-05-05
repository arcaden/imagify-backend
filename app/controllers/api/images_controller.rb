class Api::ImagesController < ApplicationController
    before_action :set_image, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def index
        @images = Image.where(public_view: true).order(created_at: :desc)
        render json: @images, status: :ok
    end

    def index_personal
        @images = Image.where(user_id: current_user.id).order(created_at: :desc)
        render json: @images, status: :ok
    end

    def create
        tags = Image.generate_tags(create_image_params[:img_file])
        @image = Image.create_image(create_image_params, current_user)
        @image.update(tags: tags)
        render json: @image, status: :ok
    end 

    def update
        @image.update(update_image_params)
        render json: @image, status: :ok
    end
    
    def destroy
        @image.destroy
        head :no_content
    end

    def show
        render json: @image, status: :ok
    end 

    def search_image
        @images = Image.search_image(image_serach_params)
        render json: @images, status: :ok
    end 
    
    private 

    def set_image
        @image = Image.find(params[:id])
    end

    def create_image_params
        params.permit(:title, :img_file, :description, :public_view, tags:[])
    end   

    def update_image_params
        params.permit(:title, :description, :public_view, tags:[])
    end   

    def image_serach_params
        params.permit(:search_by, :search_value, tags:[])
    end   
end
