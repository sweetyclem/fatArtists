class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.boolean :active, :default => false
      t.integer :user_id
      t.string :firstName
      t.string :lastName
      t.string :website
      t.integer :location
      t.integer :typeOfWork
      t.integer :fatCategory
      t.integer :orientation
      t.integer :religion
      t.integer :ethnicity

      t.timestamps
    end
  end
end
