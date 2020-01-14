class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.belongs_to :venue
      t.string :name
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
