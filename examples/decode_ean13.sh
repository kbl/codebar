#!/usr/bin/env ruby

require_relative '../lib/codebar'

file_path = File.join(File.dirname(__FILE__), '..', 'spec', 'images', 'ean13_clear2.png')

barcode = Codebar::Barcode.new(file_path)
p barcode.decode(:ean13)
