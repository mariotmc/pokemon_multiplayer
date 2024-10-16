class Message < ApplicationRecord
  belongs_to :player
  validates :content, presence: true

  def render_messages
    broadcast_update_to(
      "chat",
      target: "messages",
      collection: Message.includes(:player).order(created_at: :desc).limit(20).reverse
    )
  end
end
