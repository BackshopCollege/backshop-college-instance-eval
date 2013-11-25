class FullText

  def self.datasource(value = nil)
    return ( @datasource || [] ) unless value
    @datasource = value
  end

  def self.search(&block)
    new.search &block
  end

  def initialize(datasource = nil)
    @datasource = datasource || FullText.datasource
  end

  def search(&proc)
    proc.call(self)
    @datasource.select { |val| val[:name] =~ Regexp.new(text, 'i') }
  end

  def text(value = nil)
    return @text || "what" unless value
    @text = value 
  end

end



