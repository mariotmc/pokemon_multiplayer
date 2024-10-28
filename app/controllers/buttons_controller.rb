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

      if response.success?
        render json: { status: 'success' }
      else
        render json: { status: 'error', message: response.body }, status: 500
      end
    rescue Net::ReadTimeout
      Rails.logger.error "HTTP error: #{e.message}"
      render json: { status: 'error', message: e.message }, status: 500
    end
  end

  private
    def authenticate_player!
      redirect_to new_player_path if Current.player.nil?
    end

    def send_button_press(button)
      HTTParty.post(
        "http://188.245.183.143:5001/mgba-http/button/tap?key=#{params[:button]}",
        headers: { "accept" => "*/*" },
        timeout: 5
      )
    end
end
