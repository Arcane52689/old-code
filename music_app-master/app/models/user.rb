# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'bcrypt'
class User < ActiveRecord::Base


  attr_reader :password

  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  after_initialize :ensure_activation_token
  after_initialize :set_activated_false
  has_many :notes




  def self.random_string
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    return nil unless user
    return user if user.is_password?(password)
    nil
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

  def reset_session_token!
    self.session_token = self.class.random_string
    self.save!
  end


  def ensure_activation_token
    self.activation_token ||= SecureRandom.urlsafe_base64(32)
  end

  def activate
    self.toggle(:activated)
    save!
  end

  def set_activated_false
    self.activated ||= false
    self.save!
  end


  def toggle_admin
    self.toggle(:admin)
    save!
  end

  def admin?
    self.admin
  end


end
