require 'spec_helper'
require 'parser_service'
require 'file_parser'

RSpec.describe 'parse logs from file' do
  subject { ParserService }
  let(:file_path) { 'spec/fixtures/test.log' }
  let(:logs_reader) { FileParser.new(file_path: file_path) }

  describe 'parsing' do
    it 'returns most viewed pages' do
      expect(subject.call(logs_reader: logs_reader)[:most_page_views]).to eq('/home' => 3, '/api' => 2, '/notes' => 1)
    end

    it 'returns most viewed pages by unique' do
      expect(subject.call(logs_reader: logs_reader)[:most_unique_views]).to eq('/home' => 2, '/api' => 2, '/notes' => 1)
    end
  end
end