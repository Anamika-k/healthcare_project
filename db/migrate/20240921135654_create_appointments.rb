class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: { to_table: :users }
      t.datetime :date, null: false
      t.text :notes

      t.timestamps
    end
  end
end
