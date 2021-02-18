# frozen_string_literal: true

class LogAnalyzer
  attr_reader :log_array, :most_page_views, :most_uniq_views

  def initialize(args = {})
    @log_array = args[:log_array] || []
    analyze_logs
  end

  def update_logs(log_array)
    return unless log_array.class == Array

    @log_array = log_array
    analyze_logs
  end

  private

  def analyze_logs
    log_hash = {}
    @log_array.each do |log|
      next unless log.class == String && log.split(' ').length == 2

      formatted_log = log.split(' ')

      log_hash = log_sorter(log_hash, formatted_log)
    end
    ordered_logs = log_orderer(log_hash)

    @most_page_views = ordered_logs[:most_page_views]
    @most_uniq_views = ordered_logs[:most_uniq_views]
  end

  def log_sorter(log_hash, formatted_log)
    visits_count = log_hash[formatted_log[0]] ? log_hash[formatted_log[0]][:visits] + 1 : 1

    log_hash[formatted_log[0]] = { visits: 1, ips: Hash.new(0) } if visits_count == 1

    log_hash[formatted_log[0]][:ips][formatted_log[1]] += 1
    log_hash[formatted_log[0]][:visits] = visits_count

    log_hash
  end

  def log_orderer(log_hash)
    orderd_logs = log_hash.map do |url, url_info|
      uniq_views = url_info[:ips].map { |_ip, count| count }.count { |visits| visits == 1 }

      { url: url, visits: url_info[:visits], uniq_views: uniq_views }
    end

    result_by_page_views = orderd_logs.map { |url| [url[:url], url[:visits]] }.sort_by { |b| b[1] }.reverse
    result_by_uniq_visits = orderd_logs.map { |url| [url[:url], url[:uniq_views]] }.sort_by { |r| r[1] }.reverse

    { most_page_views: result_by_page_views, most_uniq_views: result_by_uniq_visits }
  end
end
