class User < ApplicationRecord
  has_secure_password

  def generate_user_reset_token!
    self.reset_password_token = SecureRandom.urlSafe_bs64
    self.reset_password_sent_at = Time.now
    save!
  end
end
