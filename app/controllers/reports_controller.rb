class ReportsController < ApplicationController
   authorize_resource :class => false

  def index
    @reports = ReportGenerator.reports_list
  end

  def show
    report_path = Rails.root.join('tmp', 'reports', "#{params[:id]}.xlsx")

    respond_to do |format|
      format.xlsx {
        send_file report_path,
                  filename: "#{params[:id]}.xlsx",
                  type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      }
    end
  end
end
