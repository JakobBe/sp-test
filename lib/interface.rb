# frozen_string_literal: true

require_relative './log_analyzer'
require_relative './log_file_parser'

puts 'Please select a logfile from ../data that you want to analyze by providing its number:'

data_files = Dir.glob('data/*log')
data_files.each_with_index { |file, index| puts "#{index + 1}. #{file}" }

user_choice = gets.chomp

while user_choice != ''
  if user_choice && (user_choice.to_i > data_files.length || user_choice.to_i.zero?)
    puts 'Wrong input please indicate another file or press enter to exit'
    user_choice = gets.chomp
    next
  end

  log_array = LogFileParser.create_log_array(data_files[user_choice.to_i - 1])

  puts "\n!!!#{log_array[:warning]}!!!\n\n" if log_array[:warning]

  log_analyzer = LogAnalyzer.new(log_array: log_array[:log_array])

  puts '-------------------'
  puts 'Urls orderd by page views:'
  log_analyzer.most_page_views.each { |url| puts "#{url[0]}, visits: #{url[1]}" }
  puts "-------------------\n\n"
  puts '-------------------'
  puts 'Urls orderd by uniq views:'
  log_analyzer.most_uniq_views.each { |url| puts "#{url[0]}, uniq views: #{url[1]}" }
  puts "-------------------\n\n"

  puts 'Press enter to exit or a number to analyze another log file'
  user_choice = gets.chomp
end

puts 'You ended the session. Have a good day'
