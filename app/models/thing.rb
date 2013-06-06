require "valid_formats"

class Thing < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :url,
    presence:   true,
    format:     { with: ValidFormats::URL },
    uniqueness: { scope: :company_id }

  validates :description, presence: true
end
