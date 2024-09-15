class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.string :status
      t.date :deadline
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
