class AddCodeToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :code, :string
  end
end
