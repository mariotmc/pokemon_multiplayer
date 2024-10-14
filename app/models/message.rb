class Message < ApplicationRecord
  belongs_to :player
  validates :content, presence: true
end
