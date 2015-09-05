class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
    	t.string :title, null: false
    	t.date :exam_date
    	t.integer :score_range
    	t.string :course_name
    	t.text :description
    	t.integer :classroom_id
      t.timestamps null: false
    end
    add_index(:exams, :classroom_id)
  end
end
