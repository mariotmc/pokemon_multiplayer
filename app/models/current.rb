class Current < ActiveSupport::CurrentAttributes
  attribute :player
  attribute :request_id, :user_agent, :ip_address

  resets { Time.zone = nil }

  def player=(player)
    super
  end
end
