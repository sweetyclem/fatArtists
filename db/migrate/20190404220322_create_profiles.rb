class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.boolean :active, :default => false
      t.integer :user_id
      t.string :firstName
      t.string :lastName
      t.string :website
      t.string :location
      t.string :typeOfWork
      t.string :fatCategory
      t.string :orientation
      t.string :religion
      t.string :ethnicity

      t.timestamps
    end
  end
end
