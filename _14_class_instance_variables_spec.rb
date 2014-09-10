class Document
  @@default_paper_size = :a4

  def self.default_paper_size
    @@default_paper_size
  end

  def self.default_paper_size=(new_size)
    @@default_paper_size = new_size
  end

  attr_accessor :title, :author, :content
  attr_accessor :paper_size
  
  def initialize(title, author, content)
    @title = title
    @author = author
    @content = content
    @paper_size = @@default_paper_size
  end

  # Rest of the class omitted...
end  

class Document1
  @default_font = :times

  class << self
    attr_accessor :default_font
  end

  def peek
    Document1.default_font
  end
end

class Dummy
  @default_font = :times

  def self.dummy
    @default_font
  end
end


describe Document do

  it 'class_variables should work' do
    expect(Document.default_paper_size).to eq(:a4)
    obj = Document.new('title', 'author', 'content')
    expect(obj.paper_size).to eq(:a4)
    Document.default_paper_size = :letter
    expect(obj.paper_size).to eq(:a4)
    obj = Document.new('title', 'author', 'content')
    expect(obj.paper_size).to eq(:letter)
  end

  it 'test class instance variable' do 
    doc = Document1.new
    expect(doc.peek).to eq(:times)
  end

  it 'test class method' do
    expect(Dummy.dummy).to eq(:times)
  end
end