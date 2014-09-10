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

describe Document do

  it 'should hold on to the contents' do
    text = 'A bunch of words'
    doc = Document.new( 'test', 'nobody', text )
    expect(doc.content).to eq(text)
  end

  it 'should return all of the words in the document' do
    text = 'A bunch of words'
    doc = Document.new( 'test', 'nobody', text )
    expect(doc.words.include?( 'A' ))
    expect(doc.words.include?( 'bunch' ))
    expect(doc.words.include?( 'of' ))
    expect(doc.words.include?( 'words' ))
    expect(false)
  end

  it 'should know how many words it contains' do
    text = 'A bunch of words'
    doc = Document.new( 'test', 'nobody', text )
    expect(doc.word_count).to eq(4)
  end

end