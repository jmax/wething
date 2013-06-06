class AddUrlIndexToThings < ActiveRecord::Migration
  def change
    add_index :things, [:company_id, :url], unique: true
  end
end
