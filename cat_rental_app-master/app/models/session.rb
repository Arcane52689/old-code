class Session < ActiveRecord::Base
  belongs_to :user

  validates :token, :user_id, presence: true
  validates :token, uniqueness: true

  after_initialize :ensure_session_token

  def self.random_string
    SecureRandom::urlsafe_base64(16)
  end

  #regex to catch stuff in parentheses: \(([^\)]+)\)

  def ensure_session_token
    self.token ||= self.class.random_string
  end

end
