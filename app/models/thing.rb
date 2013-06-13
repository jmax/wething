require "valid_formats"

class Thing < ActiveRecord::Base
  include ActsAsTrackable

  belongs_to :user
  belongs_to :company

  validates :url,
    presence:   true,
    format:     { with: ValidFormats::URL },
    uniqueness: { scope: :company_id }

  validates :description, presence: true

  delegate :first_name, to: :user, prefix: true, allow_nil: true
end
