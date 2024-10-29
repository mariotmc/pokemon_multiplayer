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
      render json: { status: "success" }
    rescue => e
      Rails.logger.error "Error: #{e.message}"
      render json: { status: "error", message: e.message }, status: 500
    end
  end

  private
    def authenticate_player!
      redirect_to new_player_path if Current.player.nil?
    end

    def send_button_press(button)
      if ENV['MGBA_NGROK_URL'].blank?
        Rails.logger.error "Error: MGBA HTTP URL not configured"
        return
      end

      HTTParty.post(
        "#{ENV['MGBA_NGROK_URL']}/mgba-http/button/tap?key=#{params[:button]}",
        headers: { "accept" => "*/*", "ngrok-skip-browser-warning" => "true" },
        timeout: 5
      )
    end
end
