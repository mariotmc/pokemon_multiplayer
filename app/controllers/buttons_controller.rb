class ButtonsController < ApplicationController
  before_action :authenticate_player!

  def index
  end

  def create
    begin
      response = HTTParty.post(
      "https://9a13-80-109-2-170.ngrok-free.app/mgba-http/button/tap?key=#{params[:button]}",
      headers: {
        "accept" => "*/*",
        "ngrok-skip-browser-warning" => "true"
      },
      timeout: 5
      )
      render json: { status: response.code, body: response.body }
    rescue Net::ReadTimeout
      render json: { error: "Request timed out" }, status: :gateway_timeout
    end
  end

  private
    def authenticate_player!
      redirect_to new_player_path if Current.player.nil?
    end
end
