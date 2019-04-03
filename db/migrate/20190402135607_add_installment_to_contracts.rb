class AddInstallmentToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :installment, :integer
  end
end
