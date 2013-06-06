class Company < ActiveRecord::Base
  has_many :users
  has_many :things

  validates :name, presence: true, uniqueness: true
end
