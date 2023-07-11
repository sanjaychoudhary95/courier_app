namespace :update_parcel do
  desc 'Update tracking number'
  task tracking_number: :environment do
    puts 'Rake task started to update tracking numbers'

    # Get all existing Parcels
    parcels = Parcel.all

    # Update the tracking number for each Parcel
    parcels.each do |parcel|
      new_tracking_number = generate_random_tracking_number

      # Ensure the new tracking number is unique
      while Parcel.exists?(tracking_number: new_tracking_number)
        new_tracking_number = generate_random_tracking_number
      end

      parcel.update(tracking_number: new_tracking_number)
    end

    puts 'Tracking numbers updated successfully'
  end

  def generate_random_tracking_number
    SecureRandom.hex(14)
  end
end
