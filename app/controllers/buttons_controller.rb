class ButtonsController < ApplicationController
  before_action :authenticate_player!

  def index
    @messages = Message.includes(:player).order(created_at: :desc).limit(20).reverse
  end

  def create
    begin
      message = Current.player.messages.create!(content: "#{params[:button]}")
      response = send_button_press(params[:button])

      Rails.logger.info "Response Status: #{response.code}"
      Rails.logger.info "Response Body: #{response.body}"
      Rails.logger.info "Response Headers: #{response.headers.inspect}"

      if response.success?
        message.render_messages
        render json: { status: response.code, body: response.body }
      else
        Rails.logger.error "Error Response: #{response.body}"
        render json: {
          error: "Server Error",
          details: response.body,
          status: response.code
        }, status: response.code
      end
    rescue Net::ReadTimeout
      render json: { error: "Request timed out" }, status: :gateway_timeout
    rescue => e
      Rails.logger.error "Unexpected error: #{e.class} - #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      render json: { error: "Unexpected error", details: e.message }, status: :internal_server_error
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
