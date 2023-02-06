# frozen_string_literal: true

require_relative '../lib/errors'
require_relative '../lib/io'

RSpec.describe Io do
  subject(:io) { described_class.new }

  describe '#ask_for_birthday' do
    subject(:ask_for_birthday) { io.ask_for_birthday }

    let(:birthday) { '1900-1-1' }
    let(:result) { Date.new(DateTime.now.year, 1, 1) }

    before do
      stdin_double = instance_double('$stdin', chomp: birthday)
      allow($stdin).to receive(:gets) { stdin_double }

      allow(io).to receive(:sleep)
    end

    it { is_expected.to eq result }

    context 'when the birthday is invalid' do
      let(:birthday) { 'string' }

      it 'raises an IoError' do
        expect { ask_for_birthday }.to raise_error(IoError)
      end
    end
  end
end
