class Post < ApplicationRecord
  belongs_to :user

  validates :user_id, :title, :description, presence: true
end
