class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :uri
      t.text :body

      t.timestamps
    end
  end
end
