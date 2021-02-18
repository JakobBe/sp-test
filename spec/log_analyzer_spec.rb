# frozen_string_literal: true

require_relative '../lib/log_analyzer'

RSpec.describe LogAnalyzer do
  context 'is instantiated without an argument' do
    it 'log array is empty' do
      expect(subject.log_array).to be_empty
    end

    it 'most page views is empty' do
      expect(subject.most_page_views).to be_empty
    end

    it 'most uniq views is empty' do
      expect(subject.most_uniq_views).to be_empty
    end
  end

  context 'is instantiated with an incorrect log array' do
    let(:log_analyzer_with_bad_logs) { LogAnalyzer.new(log_array: [1, 2, 3, '/contact 2']) }

    it 'dose not break' do
      expect(log_analyzer_with_bad_logs).to be_truthy
    end
  end

  context 'is instantiated with a correct log array' do
    subject { LogAnalyzer.new(log_array: ['/help 1', '/help 1', '/help 1', '/faq 1', '/faq 2', '/contact 1']) }

    context 'most page views' do
      it 'returns the page views sorted from high to low' do
        expect(subject.most_page_views.first[1]).to be > subject.most_page_views.last[1]
      end

      it 'returns the page views with url and count' do
        expect(subject.most_page_views).to eq([['/help', 3], ['/faq', 2], ['/contact', 1]])
      end
    end

    context 'most uniq views' do
      it 'returns the uniq views sorted from high to low' do
        expect(subject.most_uniq_views.first[1]).to be > subject.most_uniq_views.last[1]
      end

      it 'returns the uniq views with url and count' do
        expect(subject.most_uniq_views).to eq([['/faq', 2], ['/contact', 1], ['/help', 0]])
      end
    end
  end
end
