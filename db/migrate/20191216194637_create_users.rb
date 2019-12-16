class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :activated
      t.boolean :admin
      t.string :activation_digest
      t.string :password_reset_digest

      t.timestamps
    end
  end
end
