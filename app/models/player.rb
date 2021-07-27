class Player < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  # validates :user_id, :name, :position, presence: true
  # validates :seasons, :number, numericality: true, presence: true
end
