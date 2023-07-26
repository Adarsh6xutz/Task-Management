class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :task_date
      t.string :status
      t.integer :assignee_id

      t.timestamps
    end
  end
end
