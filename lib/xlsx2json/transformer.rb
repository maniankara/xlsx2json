require 'creek'
require 'json'

module Xlsx2json
  class Transformer
    attr_accessor :xlsx_path,
                  :json_path,
                  :shhet_number
    def initialize xlsx_path, shhet_number, json_path
      @xlsx_path = xlsx_path
      @json_path = json_path
      @shhet_number = shhet_number
      initiate_json
    end

    def self.execute xlsx_path, shhet_number, json_path
      sql = Transformer.new xlsx_path, shhet_number, json_path
      sql.run
    end

    def run
      creek = Creek::Book.new @xlsx_path
      creek.sheets[@shhet_number].rows.each_with_index do |r, i|
        number = i + 1
        if i.eql? 0
          process_header r
        else
          process_record(r, number) unless r.empty?
        end
      end
      finalize_json
      @json_path
    end

    private
    def process_header header_row
      @col_to_field_maping = Hash.new
      header_row.invert.each do |k,v|
        field = v.gsub('1', '') 
        col = k.field_name_friendly
        @col_to_field_maping[field] = col
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
