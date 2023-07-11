require 'axlsx'

class ReportGenerator
  REPORTS_FOLDER = Rails.root.join('tmp', 'reports').freeze

  def self.generate_report
    # Create the reports directory if it doesn't exist
    FileUtils.mkdir_p(REPORTS_FOLDER)

    # Fetch the data for the report
    parcels = Parcel.includes(:sender, :receiver)

    # Create a new workbook
    p = Axlsx::Package.new
    wb = p.workbook

    # Add a worksheet
    wb.add_worksheet(name: 'Report') do |sheet|
      # Add headers
      sheet.add_row ['Tracking Number','Weight', 'Status', 'Service Type id', 'Sender Name', 'Receiver Name']

      # Add data rows
      parcels.each do |parcel|
        sheet.add_row [parcel.tracking_number, parcel.weight, parcel.status, parcel.service_type.name, parcel.sender.name, parcel.receiver.name]
      end
    end

    # Save the workbook to a file
    file_path = REPORTS_FOLDER.join("#{Time.zone.now.to_date}.xlsx")
    p.serialize(file_path)

    file_path
  end

  def self.reports_list
    Dir.glob(REPORTS_FOLDER.join('*.xlsx')).map { |file| File.basename(file) }.sort.reverse
  end
end
