class CreateTools < ActiveRecord::Migration[6.1]
  def change
    create_table :tools do |t|
      t.string :store_name, null: false
      t.integer :total_unit, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
