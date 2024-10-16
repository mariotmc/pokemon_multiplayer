class CreatePlayer < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :color
      t.timestamps
    end
  end
end