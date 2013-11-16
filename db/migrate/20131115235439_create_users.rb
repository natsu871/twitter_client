class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :email, :unique => true
      t.string :encrypted_password, :null => false
      t.string :salt
      t.boolean :admin, :default => false
      t.timestamps
    end
  end
end
