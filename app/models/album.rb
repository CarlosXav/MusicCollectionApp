class Album < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :artist, presence: true, length: {minimum: 1, maximum: 100}
  validates :description, length: {minimum: 0, maximum: 300}
  validates :user_id, presence: true, numericality: { only_integer: true }
end
