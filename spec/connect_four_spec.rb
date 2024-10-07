# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  subject(:connect_four) { described_class.new }
  describe '#initialize' do
    it 'creates a bucket array with 7 columns' do
      expect(connect_four.buckets).to eq([[], [], [], [], [], [], []])
    end
  end

  describe '#inbound?' do
    it 'returns true if column is between 0 and 6 and row is between 0 and 5' do
      expect(connect_four.inbound?(1, 4)).to be(true)
    end
    it 'returns false if column is between 0 and 6 but row is out of bound' do
      expect(connect_four.inbound?(6, 1)).to be(false)
    end
    it 'returns false if column is out of bound and row is inbound' do
      expect(connect_four.inbound?(4, 8)).to be(false)
    end
    it 'returns false if column is out of bound and row is also out of bound' do
      expect(connect_four.inbound?(10, 8)).to be(false)
    end
  end
  describe '#game_over?' do
    allow(connect_four).to receive(:buckets).and_return([[1, 1, 1, 0], [0, 0, 1], [1, 1, 0], [0, 0, 1], [1, 0, 1],
                                                         [1, 1, 0], [0, 0, 0, 0]])
    it 'returns true when there is a four consecutive numbers' do
      expect(connect_four.game_over?(3, 6)).to be(true)
    end
    it "returns false when there isn't" do
      expect(connect_four.game_over?(2, 0)).to be(false)
    end
  end
end
