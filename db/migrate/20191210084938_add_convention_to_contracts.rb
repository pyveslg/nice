class AddConventionToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :convention, :boolean, default: false
  end
end
