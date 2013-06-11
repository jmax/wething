class CreateUserViews < ActiveRecord::Migration
  def change
    create_table :user_views do |t|
      t.belongs_to :user,  index: true
      t.belongs_to :thing, index: true

      t.timestamps
    end
  end
end
