require 'set'

class ParserService
  def initialize(logs_reader:)
    @logs_reader = logs_reader

    @most_page_views = {}
    @most_unique_views = {}
  end

  def self.call(logs_reader:)
    new(logs_reader: logs_reader).call
  end

  def call
    result = parse_logs

    if result
      {
        most_page_views: sorted_most_page_views,
        most_unique_views: sorted_most_unique_views
      }
    else
      false
    end
  end

  private

  attr_reader :logs_reader

  def parse_logs
    logs_reader.parse do |page, ip|
      add_most_viewed(page: page)
      add_unique_viewed(page: page, ip: ip)
    end
  end

  def sorted_most_page_views
    @most_page_views.sort_by { |_page, views| -views }.to_h
  end

  def sorted_most_unique_views
    @most_unique_views.map { |page, unique_views| [page, unique_views.size] }.sort_by { |_k, v| -v }.to_h
  end

  def add_most_viewed(page:)
    @most_page_views[page] = @most_page_views[page].nil? ? 1 : @most_page_views[page] += 1
  end

  def add_unique_viewed(page:, ip:)
    if @most_unique_views[page]
      @most_unique_views[page].add(ip)
    else
      @most_unique_views[page] = Set.new([ip])
    end
  end
end
