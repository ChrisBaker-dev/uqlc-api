class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    rescue_from Exception do |error|
        render json: { error: error }, status: :not_found
    end

    def index
        render json: Post.order(updated_at: :desc)
    end

    def show
        render json: @post
    end


    def create
        #post = Post.create(post_params)
        render json: Post.create(post_params), staus: :created
    end

    def update
        if @post.update(post_params)
            render json: @post
        else
            render json: {error: "Failed to update post"}, status: :unprocessable_entity
        end
    end

    def destroy
        if @post.destroy
            render json: {message: "Post was deleted" }, status: :no_content
        else
            render json: { error: "Unable to delete post" }, status: :unprocessable_entity
        end
    end


    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.permit(:user_id, :title, :description)
    end

end