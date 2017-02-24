class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :filename
      t.string :id_field

      t.timestamps
    end
  end
end
