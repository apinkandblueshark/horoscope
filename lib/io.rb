# frozen_string_literal: true

require 'date'

require_relative 'errors'

class Io
  def ask_for_birthday
    say "What is your birthday?\n"

    birthday = $stdin.gets.chomp

    format_birthday(birthday)
  end

  def sing(lyric)
    say "#{lyric.name}\n\n"
    slow_talk "#{lyric.lyric}\n\n"
    say outro
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

    raise IoError, 'invalid birthday'
  end

  def outro
    "That's your horoscope for today (that's your horoscope for today)\nThat's your horoscope for today\n" \
      "That's your horoscope for today (that's your horoscope for today)\nThat's your horoscope for today " \
      "(that's your horoscope for today)\n"
  end

  def slow_talk(str, speed: 0.10)
    str.each_char do |c|
      say c
      sleep speed
    end
  end
end
