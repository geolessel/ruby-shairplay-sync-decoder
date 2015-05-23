#!/usr/bin/env ruby

require 'rexml/document'

# Translate hex codes to human-readable strings
CODES = {
  '6173616c' => 'Album',
  '61736172' => 'Artist',
  '61736370' => 'Composer',
  '6173676e' => 'Genre',
  '6d696e6d' => 'Item name',
  '6173746e' => 'Song Track #',
  '6173646b' => 'Song Data Kind',
  '63617073' => 'caps', #???
  '6173746d' => 'Song Time',
}

FILENAME = '/tmp/shairport-sync-metadata'

file = open(FILENAME)
loop do
  line = file.gets
  case line
  when %r{^<metadata-group>}
    metadata = line
  when %r{^</metadata-group>}
    metadata << line
    group_end = true
  else
    metadata << line
  end

  if group_end
    # parse xml
    doc = REXML::Document.new(metadata)
    doc.elements.each('code') do |element|
      puts element.text
    end
    group_end = false
  end
end
