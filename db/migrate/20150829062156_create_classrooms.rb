class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
    	t.string :name
    	t.integer :teacher_id, null: false
    	t.string :courses_name
      t.timestamps null: false
    end
    add_index(:classrooms, :teacher_id)
  end
end
