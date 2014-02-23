class String
  def field_name_friendly
    self.gsub(/\W+/, '').downcase
  end

  def field_name_friendly!
    self.gsub!(/\W+/, '').downcase!
  end
  
  def between_markers marker1, marker2
    self[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end

  def is_number?
    true if Float(self) rescue false
  end  
end