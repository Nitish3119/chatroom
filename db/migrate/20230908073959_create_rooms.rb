class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :title
      t.integer :created_by

      t.timestamps
    end
  end
end
