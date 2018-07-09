class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :house_number
      t.string :street_name
      t.string :street_type
      t.string :street_predirection
      t.string :street_postdirection
      t.string :unit_number
      t.string :unit_type
      t.string :city
      t.string :state
      t.string :county
      t.string :zip_5
      t.string :zip_4
      t.timestamps
    end
  end
end
