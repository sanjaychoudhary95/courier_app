class CreateReportJobWorker
  include Sidekiq::Worker

  def perform(*args)
    ReportGenerator.generate_report
  end
end
