class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update]

    rescue_from Exception do |error|
        render json: { error: error }, status: :not_found
    end

    def index
        render json: Post.order(updated_at: :desc), status: :ok
    end

    def show
        if @post
            render json: @post, status: :ok
        else
            render json: { error: "Can not show post" }, status: :unprocessable_entity
        end
    end


    def create
        #post = Post.create(post_params)
        post = Post.new(post_params)
        if post.save
            render status: :created
        else
            render status: :unprocessable_entity
        end
    end

    def update
        if @post.update(post_params)
            render json: @post
        else
            render json: {error: "Failed to update post"}, status: :unprocessable_entity
        end
    end

    def destroy
        @post = Post.find(params[:id])
        if @post.destroy
            render json: { message: "Post was deleted" }, status: :ok
        else
            render json: { error: "Unable to delete post" }, status: :unprocessable_entity
        end
    end


    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.permit(:user_id, :title, :description, :image)
    end
end