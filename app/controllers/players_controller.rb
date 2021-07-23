class PlayersController < ApplicationController
    before_action :set_player, only: [:show]

    def index
        render json: Player.order(updated_at: :desc)
    end

    def show
        render json: @player
    end

    def create
        render json: Player.create()
    end




    

    private

    def set_player
        @player = Player.find(params[:id])
    end

    def player_params
        params.permit(:user_id, :name, :number, :position, :description, :seasons)
    end

end
