class FileParser
  def initialize(file_path:)
    @file_path = file_path
  end

  def parse
    File.open(file_path, 'r') do |f|
      f.each_line do |line|
        if block_given?
          host, ip = line.split
          yield(host, ip)
        else
          line
        end
      end
    end
  rescue
    Rails.logger.error(e)
    false
  end

  private

  attr_reader :file_path
end
