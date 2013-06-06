class Company < ActiveRecord::Base
  devise :rememberable, :registerable

  has_many :users

  validates :name, presence: true, uniqueness: true
end
