class User < ApplicationRecord
    has_secure_password
    has_many :posts

    validates :email, presence: true, uniqueness: true

    def generate_password_token!
        self.reset_password_token = generate_token
        self.reset_password_sent_at = Time.now.aest
        save!
    end

    def password_token_valid?
        Time.now.aest < (self.reset_password_sent_at + 2.hours)
    end

    def reset_password(password)
        self.reset_password_token = nil
        self.password = password
        save!
    end

    private

    def generate_token
        SecureRansom.hex(10)
    end
end
