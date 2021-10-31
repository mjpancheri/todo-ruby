require 'csv'

module Exportable
  extend ActiveSupport::Concern

  def export_csv
    headers = ['ID', 'Description', 'Done?', 'Parent ID', 'Created At', 'Updated At']

    csv = CSV.generate(write_headers: true, headers: headers) do |row|
      Task.all.each do |task|
        row << [task.id, task.description, task.done, task.parent_id, task.created_at, task.updated_at]
      end
    end

    send_data csv, type: 'text/csv; charset=utf-8; headers=present', 
      disposition: "attachment; filename=tasks-#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
  end
end
