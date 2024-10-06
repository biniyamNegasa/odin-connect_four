# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#initialize' do
    subject(:connect_four) { described_class.new }
    it 'creates a bucket array with 7 columns' do
      expect(connect_four.buckets).to eq([[], [], [], [], [], [], []])
    end
  end
end
