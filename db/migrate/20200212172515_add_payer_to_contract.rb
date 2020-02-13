class AddPayerToContract < ActiveRecord::Migration[5.2]
  def change
    add_column :contracts, :direct_payment, :boolean, default: false
    add_column :contracts, :payer, :text
  end
end
