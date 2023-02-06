# frozen_string_literal: true

require 'date'

require_relative 'errors'

class Io
  def ask_for_birthday
    print "What is your birthday?\n"

    birthday = $stdin.gets.chomp

    format_birthday(birthday)
  end

  def sing(lyric)
    say "#{lyric.name}\n"
    say "\n"
    say "#{lyric.lyric}\n"
    say "\n"

    outro
  end

  def say(str)
    print str
  end

  private

  def format_birthday(birthday)
    birthdate = Date.parse(birthday)

    Date.new(DateTime.now.year, birthdate.month, birthdate.day)
  rescue Date::Error
    print "Invalid birthday!\n\n"

    raise HoroscopeError, 'invalid birthday'
  end

  def outro
    print "That's your horoscope for today (that's your horoscope for today)\nThat's your horoscope for today\n" \
          "That's your horoscope for today (that's your horoscope for today)\nThat's your horoscope for today " \
          "(that's your horoscope for today)\n"
  end
end
