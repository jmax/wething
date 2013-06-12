require "valid_formats"

class Thing < ActiveRecord::Base
  belongs_to :user
  belongs_to :company
  has_many   :user_views
  has_many   :viewers, through: :user_views, source: :user
  has_many   :user_favorites
  has_many   :favoriters, through: :user_favorites, source: :user

  validates :url,
    presence:   true,
    format:     { with: ValidFormats::URL },
    uniqueness: { scope: :company_id }

  validates :description, presence: true
end
