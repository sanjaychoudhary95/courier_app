class AddTrackingNumberToParcels < ActiveRecord::Migration[6.1]
  def change
    add_column :parcels, :tracking_number, :string
    add_index :parcels, :tracking_number, unique: true
  end
end
