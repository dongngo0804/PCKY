class ChangeDataTypeForParsed < ActiveRecord::Migration[5.0]
  def change
    change_column :sentences, :parsed, :text
  end
end
