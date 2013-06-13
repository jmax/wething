class User < ActiveRecord::Base
  include ActsAsViewer
  include ActsAsFavoriter
  include ActsAsCompanyMan

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :things

  validates :first_name, :last_name, presence: true
end
