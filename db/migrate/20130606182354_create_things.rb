class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.belongs_to :user,    index: true
      t.belongs_to :company, index: true
      t.string     :url
      t.text       :description

      t.timestamps
    end
  end
end
