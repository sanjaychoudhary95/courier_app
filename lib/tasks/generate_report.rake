desc 'Generate and save daily report'
task generate_report: :environment do
  file_path = ReportGenerator.generate_report
  puts "Report generated and saved at: #{file_path}"
end
