# frozen_string_literal: true

require 'active_model'

class Lyric
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON

  attr_accessor :name, :lyric

  attribute :start_date, :date
  attribute :end_date, :date

  def self.from_collection(json)
    json.map { |item| new.from_json(item.to_json) }
  end

  def self.from_file(file_path)
    file = File.read(file_path)
    json = JSON.parse(file)

    from_collection(json)
  end

  def self.find_lyric(birthdate)
    lyrics.find { |lyric| lyric.covers_birthdate?(birthdate) }
  end

  def self.lyrics
    @lyrics ||= Lyric.from_file('./lib/lyrics.json')
  end

  def covers_birthdate?(birthdate)
    (start_date..end_date).cover?(birthdate)
  end
end
