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
    @before_change_self = eval("self", proc.binding)
    (proc.arity > 0) ? proc.call(self) : self.instance_eval(&proc)
    @datasource.select { |val| val[:name] =~ Regexp.new(text, 'i') }
  end

  def text(value = nil)
    return @text || "what" unless value
    @text = value 
  end

  def method_missing(method, *args, &block)
    block = (proc {} )unless block_given?
    @before_change_self.send(method, *args, &block)
  end

end



