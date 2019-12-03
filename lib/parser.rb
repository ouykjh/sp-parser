require './parser_service'
require './file_parser'

unless ARGV[0]
  puts 'No file given'
  exit 1
end

parsed_logs = ParserService.call(logs_reader: FileParser.new(file_path: ARGV[0]))

if parsed_logs
  puts 'list of webpages with most page views ordered from most pages views to less page views: '
  parsed_logs[:most_page_views].each do |page, views|
    puts "#{page} #{views}"
  end

  puts 'list of webpages with most unique page views also ordered: '
  parsed_logs[:most_unique_views].each do |page, views|
    puts "#{page} #{views}"
  end
end