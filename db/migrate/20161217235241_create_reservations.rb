class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :state
      t.references :user, foreign_key: true
      t.references :flat, foreign_key: true
      t.monetize :amount, currency: {present: false}
      t.json :payment

      t.timestamps
    end
  end
end
