class ChangeClientTypeInContracts < ActiveRecord::Migration[5.2]
  def change
    execute "ALTER TABLE contracts ALTER COLUMN client_type TYPE boolean USING client_type::boolean, ALTER COLUMN client_type SET DEFAULT FALSE"
  end
end
