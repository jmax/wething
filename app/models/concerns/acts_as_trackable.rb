module ActsAsTrackable
  extend ActiveSupport::Concern

  included do
    has_many   :user_views
    has_many   :viewers,    through: :user_views,     source: :user
    has_many   :user_favorites
    has_many   :favoriters, through: :user_favorites, source: :user
  end
end
