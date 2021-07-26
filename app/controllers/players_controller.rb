class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :update, :destroy]

    rescue_from Exception do |error|
        render json: { error: error }, status: :not_found
    end

    def index
        render json: Player.order(updated_at: :desc)
    end

    def showcase
        render json: Player.where(approved: true).order(updated_at: :desc)
    end

    def show
        if @player.length > 0
            render json: @player, status: :ok
        else
            render json: { error: "Player id #{params[:id]} not found"}, status: :not_found
        end
    end

    def create
        render json: Player.create(player_params), status: :created
    end

    def update
        if @player.update(player_params)
            render json: @player, status: :ok
        else
            render json: { error: "Unable to update player" }, status: :unprocessable_entity
        end
    end

    def destroy
        if @player.destroy
            render json: { message: "Player was deleted" }, status: :ok
        else
            render json: { error: "Unable to delete player" }, status: :unprocessable_entity
        end
    end




    private

    def set_player
        @player = Player.where(user_id: params[:id])
    end

    def player_params
        params.permit(:user_id, :name, :number, :position, :description, :seasons, :approved)
    end

end
