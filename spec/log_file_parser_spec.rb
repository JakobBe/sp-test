# frozen_string_literal: true

require_relative '../lib/log_file_parser'

RSpec.describe LogFileParser do
  it 'creates a parser' do
    expect(subject).to be_truthy
  end

  context 'when the path is incorrect' do
    it 'returns nil for log_array' do
      expect(subject.create_log_array('Foo')).to be_nil
    end
  end

  context 'when called with a correct path' do
    it 'returns a hash' do
      expect(subject.create_log_array('data/webserver.log').class).to eq(Hash)
    end

    it 'returns a hash with a log_array' do
      expect(subject.create_log_array('data/webserver.log')[:log_array].class).to eq(Array)
    end
  end
end
