class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :destroy
    has_one :player, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
