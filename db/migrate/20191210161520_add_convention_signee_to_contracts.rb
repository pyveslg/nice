class AddConventionSigneeToContracts < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :convention_signee, :text
    add_column :contracts, :ext_group, :boolean
  end
end
