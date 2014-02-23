require 'xlsx2json'

describe 'Xlsx2json' do
  before(:all) do
    @expected_rows = [{"sku"=>"P01", "region"=>"US", "bu"=>"Book", "sales"=>"100", "margin"=>"0.4", "year"=>"2001"}, {"sku"=>"P02", "region"=>"UK", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.1", "year"=>"2004"}, {"sku"=>"P03", "region"=>"EU", "bu"=>"Book", "sales"=>"100", "margin"=>"0.7", "year"=>"2008"}, {"sku"=>"P04", "region"=>"US", "bu"=>"Book", "sales"=>"200", "margin"=>"0.45", "year"=>"2014"}, {"sku"=>"P05", "region"=>"US", "bu"=>"Paper", "sales"=>"100", "margin"=>"0.27", "year"=>"1993"}, {"sku"=>"P06", "region"=>"UK", "bu"=>"Book", "sales"=>"100", "margin"=>"0.4", "year"=>"2004"}, {"sku"=>"P07", "region"=>"US", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.1", "year"=>"2008"}, {"sku"=>"P08", "region"=>"UK", "bu"=>"Book", "sales"=>"100", "margin"=>"0.7", "year"=>"2014"}, {"sku"=>"P09", "region"=>"EU", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.45", "year"=>"2004"}, {"sku"=>"P10", "region"=>"EU", "bu"=>"Book", "sales"=>"300", "margin"=>"0.7", "year"=>"2008"}, {"sku"=>"P11", "region"=>"US", "bu"=>"Book", "sales"=>"100", "margin"=>"0.45", "year"=>"2014"}, {"sku"=>"P12", "region"=>"UK", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.27", "year"=>"1993"}, {"sku"=>"P13", "region"=>"EU", "bu"=>"Book", "sales"=>"100", "margin"=>"0.7", "year"=>"2004"}, {"sku"=>"P14", "region"=>"US", "bu"=>"Book", "sales"=>"200", "margin"=>"0.45", "year"=>"2008"}, {"sku"=>"P15", "region"=>"US", "bu"=>"Paper", "sales"=>"100", "margin"=>"0.27", "year"=>"2004"}, {"sku"=>"P16", "region"=>"UK", "bu"=>"Book", "sales"=>"100", "margin"=>"0.4", "year"=>"2008"}, {"sku"=>"P17", "region"=>"US", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.7", "year"=>"2014"}, {"sku"=>"P18", "region"=>"UK", "bu"=>"Book", "sales"=>"100", "margin"=>"0.45", "year"=>"2004"}, {"sku"=>"P19", "region"=>"EU", "bu"=>"Paper", "sales"=>"200", "margin"=>"0.27", "year"=>"2008"}, {"sku"=>"P20", "region"=>"EU", "bu"=>"Book", "sales"=>"300", "margin"=>"0.4", "year"=>"2014"}, {"sku"=>nil, "region"=>nil, "bu"=>nil, "sales"=>nil, "margin"=>nil, "year"=>nil}, {"sku"=>nil, "region"=>"ggggggggg"}]
  end

  it 'run a sql statment with start notation in the select clause successfully.' do
    json_path = Xlsx2json::Transformer.execute 'spec/fixtures/fixture_2.xlsx', 0, '/Users/developer/information.json'
    json_path.should eql "/Users/developer/information.json"
    json = JSON.parse(File.open(json_path).read)
    json.pop # poping the last empty hash that closed the json.
    @expected_rows.should eql json
  end
end
