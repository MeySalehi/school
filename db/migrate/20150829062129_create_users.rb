class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :password_digest
    	t.string :access_level
    	t.string :role

      t.timestamps null: false
    end
   	add_attachment :users, :avatar
  end
end
