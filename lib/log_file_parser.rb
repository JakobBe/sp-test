# frozen_string_literal: true

module LogFileParser
  def self.create_log_array(file_path)
    return nil unless File.file?(file_path)

    file = File.open(file_path)
    row_array = file.map(&:chomp)
    file.close

    log_array = row_array.select { |row| row.class == String && row.split(' ').length == 2 }

    warning = log_array.length < row_array.length ? 'Some rows are in bad format' : nil

    { warning: warning, log_array: log_array }
  end
end
