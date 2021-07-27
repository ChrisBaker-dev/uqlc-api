class AddImageurlToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :imageurl, :string
  end
end
