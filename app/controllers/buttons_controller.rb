class ButtonsController < ApplicationController
  before_action :authenticate_player!

  def index
    @messages = Message.includes(:player).order(created_at: :desc).limit(20).reverse
  end

  def create
    require 'socket'

    begin
      # Connect directly to mGBA
      socket = TCPSocket.new('localhost', 8888)
      message = "mgba-http.button.tap,#{params[:button]}"

      Rails.logger.info "Sending to mGBA: #{message}"
      socket.puts(message)

      response = socket.gets
      Rails.logger.info "Response from mGBA: #{response}"

      socket.close

      render json: { status: 'success', response: response }
    rescue => e
      Rails.logger.error "Socket error: #{e.message}"
      render json: { status: 'error', message: e.message }, status: 500
    end
  end

  private
    def authenticate_player!
      redirect_to new_player_path if Current.player.nil?
    end

    def send_button_press(button)
      url = "http://188.245.183.143:5000/mgba-http/button/tap?key=#{params[:button]}"
      Rails.logger.info "Sending request to: #{url}"

      Rails.logger.info "Expected socket message: mgba-http.button.tap,#{params[:button]}"

      HTTParty.post(
        url,
        headers: { "accept" => "*/*" },
        timeout: 5
      )
    end
end
