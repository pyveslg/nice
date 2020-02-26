class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.integer :programme
      t.string :code
      t.boolean :client_is_business, default: false
      t.integer :number_of_participants
      t.json :participants, default: []
      t.date :start_from
      t.date :end_at
      t.float :hours
      t.json :sessions, default: []
      t.json :frequency, default: []
      t.string :day_of_classes, default: [], array: true
      t.boolean :schedule_is_defined, default: false
      t.string :timeslots, default: [], array: true
      t.string :schedules, default: [], array: true
      t.string :client_first_name
      t.string :client_last_name
      t.string :client_tel
      t.string :client_email
      t.string :client_address
      t.string :client_zipcode
      t.string :client_city
      t.string :company_name
      t.string :company_address
      t.string :company_zipcode_string
      t.string :company_siret
      t.string :company_city
      t.integer :hourly_rate
      t.integer :payment_condition
      t.integer :installment
      t.string :level_target
      t.text :content
      t.boolean :museum, default: false
      t.boolean :access_to_neo, default: true

      t.timestamps
    end
  end
end
