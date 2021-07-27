class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :update]

    rescue_from Exception do |error|
        render json: { error: error }, status: :not_found
    end

    def index
        render json: Player.order(updated_at: :desc), status: :ok
    end

    def showcase
        render json: Player.where(approved: true).order(updated_at: :desc)
    end

    def show
        if @player
            render json: @player, status: :ok
        else
            render json: { error: "Player id #{params[:id]} not found"}, status: :not_found
        end
    end

    def create
        @player = Player.new(player_params)
        if @player.save
            render json: @player, status: :created
        else
            render json: { error: "player not created" }, status: :unprocessable_entity
        end
    end

    def update
        if @player.update(player_params)
            render json: @player, status: :ok
        else
            render json: { error: "Unable to update player" }, status: :unprocessable_entity
        end
    end

    def destroy
        @player = Player.find(params[:id])
        if @player.destroy
            render json: { message: "Player was deleted" }, status: :ok
        else
            render json: { error: "Unable to delete player" }, status: :unprocessable_entity
        end
    end




    private

    def set_player
        @player = Player.find_by(user_id: params[:id])
    end

    def player_params
        params.permit(:user_id, :name, :number, :position, :description, :seasons, :approved, :imageurl)
    end

end
