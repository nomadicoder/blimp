class AddDatafileToDocument < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :datafile, :string
  end
end
