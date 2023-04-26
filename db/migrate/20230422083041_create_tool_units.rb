class CreateToolUnits < ActiveRecord::Migration[6.1]
  def change
    create_table :tool_units do |t|
      t.integer :number, null: false
      t.integer :medal
      t.references :tool, foreign_key: true

      t.timestamps
    end
  end
end
