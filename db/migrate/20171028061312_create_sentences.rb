class CreateSentences < ActiveRecord::Migration[5.0]
  def change
    create_table :sentences do |t|
      t.string :raw
      t.string :parsed
      t.string :tokens
      t.string :terminal
      t.string :non_terminal

      t.timestamps
    end
  end
end
