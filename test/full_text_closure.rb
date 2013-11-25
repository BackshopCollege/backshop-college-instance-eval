require_relative "test_helper"

class FullTextClosure < Test::Unit::TestCase

  def setup
    FullText.datasource([{name: 'thiago teixeira'}, {name: 'linkedcare'}, {name: 'ruby in love'}])
  end
  
  def test_search_using_locals
    term = "thiago"
    actual = FullText.search do
      text term
    end

    assert_equal 1, actual.length
    assert !!(actual.first[:name] =~ Regexp.new(term, 'i'))
  end

  def fetch_term
    "thiago"
  end

  def test_search_using_method_closure
    assert_nothing_raised "Method Closure Failed" do
     FullText.search do 
        text fetch_term
      end
    end
  end

end