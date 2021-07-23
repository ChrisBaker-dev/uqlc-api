class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :position
      t.integer :number
      t.integer :seasons
      t.string :description

      t.timestamps
    end
  end
end
