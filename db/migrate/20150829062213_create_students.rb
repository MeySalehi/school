class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.integer :classroom_id
    	t.string :first_name
    	t.string :last_name
    	t.string :middle_name
    	t.string :id_number
    	t.string :birth_date
    	t.string :address
      t.string :phone
    	t.text :description

      t.timestamps null: false
    end
   	add_attachment :students, :avatar
   	add_index(:students, :classroom_id)
  end
end
