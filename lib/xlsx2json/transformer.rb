require 'creek'
require 'json'

module Xlsx2json
  class Transformer

    attr_accessor :xlsx_path, :json_path, :shhet_number, :header_row_number, :header_row_translations

    def initialize xlsx_path, shhet_number, json_path, options={}
      @xlsx_path, @json_path, @shhet_number = xlsx_path, json_path, shhet_number
      @header_row_number = (options.has_key? :header_row_number) ? options[:header_row_number].to_i : 1
      @header_row_translations = (options.has_key? :header_row_translations) ? options[:header_row_translations] : {}
    end

    def self.execute xlsx_path, shhet_number, json_path, options={header_row_number: 1}
      sql = Transformer.new xlsx_path, shhet_number, json_path, options
      sql.run
    end

    def run
      initiate_json
      transform_2_json
      finalize_json
      @json_path
    end

    private
    def transform_2_json
      creek = Creek::Book.new @xlsx_path
      creek.sheets[@shhet_number].rows.each_with_index do |r, i|
        number = i + 1
        if number < header_row_number
          next
        elsif number.eql? header_row_number
          process_header r
        else
          process_record(r, number) unless r.empty?
        end
      end
    end

    def process_header header_row
      @col_to_field_maping = Hash.new

      header_row.invert.each do |k,v|
        unless k.nil? or v.nil?
          @header_row_translations.each do |from, to|
            k = to if k.gsub(/\W+/, '').downcase.eql? from
          end
          field = v.gsub("#{@header_row_number}", '')
          col = k.gsub(/\W+/, '').downcase
          @col_to_field_maping[field] = col
        end
      end
    end

    def process_record record_row, row_number
      row_hash = Hash.new

      record_row.each do |k, v|
        curr_col = k.gsub row_number.to_s, ''
        curr_field = @col_to_field_maping[curr_col]
        cell_content = v
        break if curr_field.nil?
        row_hash[curr_field] = cell_content
      end

      append_to_json row_hash
    end

    def initiate_json
      File.open(@json_path, 'w') {|f| f.write('[') }
    end

    def append_to_json row_hash
      File.open(@json_path, 'a') {|f| f.write(row_hash.to_json + ',') }
    end

    def finalize_json
      File.open(@json_path, 'a') {|f| f.write('{}]') }
    end
  end
end
