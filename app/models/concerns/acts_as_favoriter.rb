module ActsAsFavoriter
  extend ActiveSupport::Concern

  included do
    has_many   :user_favorites
    has_many   :favorited_things, through: :user_favorites, source: :thing
  end

  def favorite(thing)
    unless favorited_things.include?(thing)
      favorited_things << thing
    end
  end
end
