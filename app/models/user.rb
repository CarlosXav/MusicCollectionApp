class User < ApplicationRecord
  before_save {self.email = email.downcase}
  before_save {self.username = username.downcase}
  has_many :albums
  validates :first_name, presence: true, length: {minimum: 1, maximum: 100}
  validates :last_name, presence: true, length: {minimum: 1, maximum: 100}
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: {minimum: 1, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: {maximum: 105}, format: { with: VALID_EMAIL_REGEX }
  has_secure_password
end
