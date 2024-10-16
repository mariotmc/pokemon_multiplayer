class ButtonsController < ApplicationController
  before_action :authenticate_player!

  def index
    @messages = Message.includes(:player).order(created_at: :desc).limit(20).reverse
  end

  def create
    begin
      message = Current.player.messages.create!(content: "#{params[:button]}")
      response = send_button_press(params[:button])

      message.render_messages if response.success?

      render json: { status: response.code, body: response.body }
    rescue Net::ReadTimeout
      render json: { error: "Request timed out" }, status: :gateway_timeout
    end
  end

  private
    def authenticate_player!
      redirect_to new_player_path if Current.player.nil?
    end

    def send_button_press(button)
      HTTParty.post(
        "https://8e0a-80-109-2-170.ngrok-free.app/mgba-http/button/tap?key=#{params[:button]}",
        headers: { "accept" => "*/*", "ngrok-skip-browser-warning" => "true" },
        timeout: 5
      )
    end
end
