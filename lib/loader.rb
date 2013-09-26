# coding: utf-8

require 'msgpack'

module Lib
  class Loader

    attr_reader :packed_file
    DATA_DIR = File.expand_path( './../data' )

    def initialize( packed_file )
      @packed_file = File.join( DATA_DIR, packed_file )
    end

    def unpack
      unpacked = nil
      File.open( @packed_file ) { |file| unpacked = MessagePack.unpack file }
      unpacked
    end
  end
end
