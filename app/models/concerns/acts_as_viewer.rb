module ActsAsViewer
  extend ActiveSupport::Concern

  included do
    has_many   :user_views
    has_many   :viewed_things, through: :user_views, source: :thing
  end

  def view(thing)
    unless thing.user == self or viewed_things.include?(thing)
      viewed_things << thing
    end
  end
end
