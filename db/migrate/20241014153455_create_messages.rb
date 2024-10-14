class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :player, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
