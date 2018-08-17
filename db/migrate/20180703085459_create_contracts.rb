class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      t.integer :programme
      t.integer :client_type
      t.integer :hourly_rate
      t.date :start_from
      t.date :end_at
      t.string :target
      t.string :sessions, array: true, default: []
      t.string :frequency, array: true, default: []
      t.string :teacher
      t.integer :payment_condition
      t.date :sign_date
      t.string :first_name
      t.string :last_name
      t.string :tel
      t.string :email
      t.string :address
      t.string :zipcode
      t.string :city
      t.string :company
      t.string :position

      t.timestamps
    end
  end
end
