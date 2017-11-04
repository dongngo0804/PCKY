class CreateRules < ActiveRecord::Migration[5.0]
  def change
    create_table :rules do |t|
      t.string :code
      t.string :left
      t.string :right
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
