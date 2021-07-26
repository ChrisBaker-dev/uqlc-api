class AddApprovedToPlayers < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :approved, :boolean
  end
end
