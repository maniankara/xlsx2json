class String
  def field_name_friendly
    self.gsub(/\W+/, '').downcase
  end

  def field_name_friendly!
    self.gsub!(/\W+/, '').downcase!
  end 
end