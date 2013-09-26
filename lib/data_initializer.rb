# coding: utf-8

require 'csv'
require 'msgpack'

module Lib
  class DataInitializer

    attr_reader :csv_file, :output_file

    DATA_DIR = File.expand_path( './../data' )

    def initialize( csv_file, output_file )
      @csv_file = File.join( DATA_DIR, csv_file )
      @output_file = File.join( DATA_DIR, output_file )
    end

    def pack
      array = Array.new
      CSV.foreach( @csv_file ) { |raw| array << raw }
      _write( array.to_msgpack )
    end

    def _write( packed )
      File.open( @output_file, 'wb' ) { |file| file.write packed }
    end
    private :_write
    
  end
end
