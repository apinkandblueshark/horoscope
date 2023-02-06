# frozen_string_literal: true

require_relative 'errors'
require_relative 'io'
require_relative 'lyric'

class Main
  def intro
    birthdate = io.ask_for_birthday

    io.say "\n"

    lyric = Lyric.find_lyric(birthdate)

    io.sing(lyric)
  rescue IoError
    intro
  end

  private

  def io
    @io ||= Io.new
  end
end
