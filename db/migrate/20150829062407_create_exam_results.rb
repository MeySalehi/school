class CreateExamResults < ActiveRecord::Migration
  def change
    create_table :exam_results do |t|
    	t.integer :student_id
    	t.integer :exam_id
    	t.integer	:result 
    	t.string :description

      t.timestamps null: false
    end
    add_index(:exam_results, :student_id)
    add_index(:exam_results, :exam_id)
  end
end
