require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  #TODO ask whether a different format would be better

  validates :user_name, uniqueness:true, presence: true
  validates :password_digest, presence:true
  validates :password, length: { minimum: 6, allow_nil: true }



  attr_reader :password

  has_many :cats,
    dependent: :destroy

  has_many :sessions,
    dependent: :destroy

  has_many :requests,
    class_name: "CatRentalRequest",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy

  def self.random_string
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name:user_name)
    return nil unless user

    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = User.random_string
    self.save!
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= self.class.random_string
  end


end
