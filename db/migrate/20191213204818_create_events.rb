class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :name
      t.text :description
      t.datetime :date
      t.string :venue
      t.timestamps
    end
  end
end
