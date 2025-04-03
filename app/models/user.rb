class User < ApplicationRecord
  has_secure_password

  def generate_user_reset_token!
    self.reset_password_token = SecureRandom.urlsafe_base64
    self.reset_password_sent_at = Time.now
    save!
  end

  def reset_password_token_update_nil
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
    save!
  end
end
