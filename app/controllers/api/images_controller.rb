class Api::ImagesController < ApplicationController
    before_action :set_image, only: [:show, :update, :destroy]
    before_action :authenticate_user!

    def index
        @images = current_user.images
        render json: @images, status: :ok
    end

    def create
        @image = Image.create_image(create_image_params, current_user)
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
