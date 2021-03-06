require 'test/unit'

class Document

  attr_accessor :title, :author, :content

  def initialize(title, author, content) 
    @title = title
    @author = author
    @content = content
  end

  def words
    @content.split
  end 

  def word_count
    words.size
  end

end 

class DocumentTest < Test::Unit::TestCase

  def test_document_holds_onto_contents
    text = 'A bunch of words'
    doc = Document.new('test', 'nobody', text)
    assert_equal text, doc.content, 'Contents are still there'
  end

  def test_that_doc_can_return_words_in_array
    text = 'A bunch of words'
    doc = Document.new('test', 'nobody', text)
    assert doc.words.include?( 'A' )
    assert doc.words.include?( 'bunch' )
    assert doc.words.include?( 'of' )
    assert doc.words.include?( 'words' )
  end

  def test_that_word_count_is_correct
    text = 'A bunch of words'
    doc = Document.new('test', 'nobody', text)
    assert_equal 4, doc.word_count, 'Word count is correct'
  end

end
