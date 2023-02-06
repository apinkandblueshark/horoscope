# frozen_string_literal: true

require_relative 'lyric'
require_relative 'errors'
require_relative 'io'

class Main
  def intro
    birthdate = io.ask_for_birthday

    io.say "\n"

    lyric = Lyric.find_lyric(birthdate)

    io.sing(lyric)
  rescue HoroscopeError
    intro
  end

  private

  def io
    @io ||= Io.new
  end
end
