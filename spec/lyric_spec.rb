# frozen_string_literal: true

require 'json'

require_relative '../lib/lyric'

RSpec.describe Lyric do
  subject(:lyric) { described_class.new }

  describe '.from_collection' do
    subject(:from_collection) { described_class.from_collection(json) }

    let(:file) { File.read('spec/fixtures/lyrics.json') }
    let(:json) { JSON.parse(file) }
    let(:result) { Lyric.new.from_json(json.first.to_json) }

    it { is_expected.to include(an_object_having_attributes(result.attributes)) }
  end

  describe '.from_file' do
    subject(:from_file) { described_class.from_file(file_path) }

    let(:file_path) { 'spec/fixtures/lyrics.json' }
    let(:json) { JSON.parse(File.read(file_path)) }

    before { allow(described_class).to receive(:from_collection) }

    it 'calls from_collection with the file contents' do
      from_file

      expect(described_class).to have_received(:from_collection).with(json)
    end
  end

  describe '#covers_birthdate?' do
    subject(:covers_birthdate?) { lyric.covers_birthdate?(birthdate) }

    let(:lyric) { described_class.new(start_date:, end_date:) }
    let(:birthdate) { Date.new(2023, 6, 6) }

    context 'when the birthdate is before the start date' do
      let(:start_date) { Date.new(2023, 6, 7) }
      let(:end_date) { Date.new(2023, 6, 8) }

      it { is_expected.to eq false }
    end

    context 'when the birthdate is after the end date' do
      let(:start_date) { Date.new(2023, 6, 2) }
      let(:end_date) { Date.new(2023, 6, 3) }

      it { is_expected.to eq false }
    end

    context 'when the birthdate is the start date' do
      let(:start_date) { Date.new(2023, 6, 6) }
      let(:end_date) { Date.new(2023, 6, 7) }

      it { is_expected.to eq true }
    end

    context 'when the birthdate is the end date' do
      let(:start_date) { Date.new(2023, 6, 5) }
      let(:end_date) { Date.new(2023, 6, 6) }

      it { is_expected.to eq true }
    end

    context 'when the birthdate is between the start and end date' do
      let(:start_date) { Date.new(2023, 6, 4) }
      let(:end_date) { Date.new(2023, 6, 10) }

      it { is_expected.to eq true }
    end
  end
end
