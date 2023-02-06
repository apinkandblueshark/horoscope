# frozen_string_literal: true

require_relative '../lib/main'

RSpec.describe Main do
  subject(:main) { described_class.new }

  describe '#intro' do
    subject(:intro) { main.intro }

    let(:birthday) { '1900-1-1' }

    let(:result) do
      <<~OUT
        What is your birthday?

        Capricorn

        The stars say that you're an exciting and wonderful person
        But, you know they're lying
        If I were you, I'd lock my doors and windows
        And never, never, never, never, never leave my house again

        That's your horoscope for today (that's your horoscope for today)
        That's your horoscope for today
        That's your horoscope for today (that's your horoscope for today)
        That's your horoscope for today (that's your horoscope for today)
      OUT
    end

    before do
      stdin_double = instance_double('$stdin', chomp: birthday)
      allow($stdin).to receive(:gets) { stdin_double }

      allow_any_instance_of(Io).to receive(:sleep)
    end

    it 'Asks for users birthday and returns the corresponding lyric' do
      expect { intro }.to output(result).to_stdout
    end

    context 'when the birthday corresponds to Aquarius' do
      let(:birthday) { '1900-01-20' }

      let(:result) do
        <<~OUT
          What is your birthday?

          Aquarius

          There's travel in your future
          When your tongue freezes to the back of a speeding bus
          Fill that void in your pathetic life
          By playing whack-a-mole 17 hours a day

          That's your horoscope for today (that's your horoscope for today)
          That's your horoscope for today
          That's your horoscope for today (that's your horoscope for today)
          That's your horoscope for today (that's your horoscope for today)
        OUT
      end

      it 'Asks for users birthday and returns the corresponding lyric' do
        expect { intro }.to output(result).to_stdout
      end
    end

    context 'when the birthday is invalid' do
      let(:birthday) { '1927-7-7' }

      let(:result) do
        <<~OUT
          What is your birthday?
          Invalid birthday!

          What is your birthday?

          Cancer

          The position of Jupiter says that
          You should spend the rest of the week face down in the mud
          Try not to shove a roll of duct tape up your nose while taking your driver's test

          That's your horoscope for today (that's your horoscope for today)
          That's your horoscope for today
          That's your horoscope for today (that's your horoscope for today)
          That's your horoscope for today (that's your horoscope for today)
        OUT
      end

      before do
        counter = 0

        allow(Date).to receive(:parse).and_call_original
        allow(Date).to receive(:parse).with(birthday) do
          counter += 1

          raise(Date::Error) if counter == 1

          Date.new(1927, 7, 7)
        end
      end

      it 'reasks for birthday' do
        expect { intro }.to output(result).to_stdout
      end
    end
  end
end
