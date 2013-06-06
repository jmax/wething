class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company

  accepts_nested_attributes_for :company
  delegate :name, to: :company, prefix: true, allow_nil: true

  validates :first_name, :last_name,:company, presence: true
  validates_associated :company
end
