module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  private
    def authenticate
      if session[:player_id] && authenticated_player = Player.find(session[:player_id])
        Current.player = authenticated_player
      else
        session[:player_id] = nil
        Current.player = nil
      end
    end
end
