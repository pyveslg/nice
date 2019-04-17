class AddCpiOnTopToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :cpi_on_top, :boolean
  end
end
