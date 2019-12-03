require 'spec_helper'
require 'parser_service'
require 'support/parser_stub'

RSpec.describe ParserService do
  subject { described_class }
  let(:file_path) { 'spec/fixtures/test.log' }
  let(:logs_reader) { ParserStub.new }

  describe '#call' do
    it 'returns most viewed pages' do
      expect(subject.call(logs_reader: logs_reader)[:most_page_views]).to eq('/home' => 3, '/api' => 2, '/notes' => 1)
    end

    it 'returns most viewed pages by unique' do
      expect(subject.call(logs_reader: logs_reader)[:most_unique_views]).to eq('/home' => 2, '/api' => 2, '/notes' => 1)
    end

    context 'parsing failed' do
      before do
        allow(logs_reader).to receive(:parse) { false }
      end
      it 'returns false' do
        expect(subject.call(logs_reader: logs_reader)).to eq(false)
      end
    end
  end
end
