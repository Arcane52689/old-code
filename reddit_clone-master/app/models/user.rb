require 'bcrypt'

class User < ActiveRecord::Base

  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  has_many :subs
  has_many :posts, class_name: "Post", foreign_key: :author_id

  has_many :comments

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user

    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= ensure_unique_token(:session_token)
  end

  def ensure_unique_token(field)
    token = SecureRandom.urlsafe_base64(16)

    until !self.class.exists?(field => token)
      token = SecureRandom.urlsafe_base64(16)
    end

    token
  end

  def reset_session_token!
    self.session_token = ensure_unique_token(:session_token)
    self.save!
    self.session_token
  end


  def password=(password)
    self.password_digest ||= BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end
