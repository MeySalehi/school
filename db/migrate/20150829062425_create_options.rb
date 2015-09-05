class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
    	t.string :namespace
    	t.string :title
    	t.string	:value
    	t.string	:default
      t.timestamps null: false
    end
  end
end
