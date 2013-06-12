class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  has_many   :things
  has_many   :user_views
  has_many   :viewed_things, through: :user_views, source: :thing
  has_many   :user_favorites
  has_many   :favorited_things, through: :user_favorites, source: :thing

  accepts_nested_attributes_for :company
  delegate :name, to: :company, prefix: true, allow_nil: true

  validates :first_name, :last_name,:company, presence: true

  def view(thing)
    unless thing.user == self or viewed_things.include?(thing)
      viewed_things << thing
    end
  end

  def favorite(thing)
    unless favorited_things.include?(thing)
      favorited_things << thing
    end
  end

end
