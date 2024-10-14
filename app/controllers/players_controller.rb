class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      session[:player_id] = @player.id
      Current.player = Player.find(session[:player_id])
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def player_params
      params.require(:player).permit(:name)
    end
end
