class CounterCacheColumnToThings < ActiveRecord::Migration
  def change
    add_column :things, :user_views_count, :integer, default: 0
  end
end
