class MessagesController < ApplicationController
  def index
    messages = Message.includes(:player).order(created_at: :desc).limit(50).map do |message|
      { message: message.content, player: message.player.name }
    end
    render json: messages.reverse
  end
end
