class Player < ApplicationRecord
  COLORS = %w[red orange amber yellow lime green emerald teal sky blue indigo violet purple fuchsia pink rose]

  validates :name, presence: true, length: { maximum: 20 }

  before_create :set_color

  has_many :messages

  private
    def set_color
      self.color = COLORS.sample
    end
end
