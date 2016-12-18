class CreateFlats < ActiveRecord::Migration[5.0]
  def change
    create_table :flats do |t|
      t.string :title
      t.string :address
      t.text :description
      t.integer :stars
      t.references :user, foreign_key: true
      t.monetize :price, currency: { present: false}
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
