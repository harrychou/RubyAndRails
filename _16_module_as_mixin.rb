class  Document
  CLICHES = [ /play fast and loose/,
              /make no mistake/,
              /does the trick/,
              /off and running/,
              /my way or the highway/ ]
  
  def number_of_cliches
    CLICHES.inject(0) do |count, phrase|
      count += 1 if phrase =~ content
      count 
    end
  end

  attr_accessor :content

  def initialize 
    @content = 'Make no mistake, I am off and running soon and quick'
  end

  # Rest of the class omitted...
end

module WritingQuality
  CLICHES = [ /play fast and loose/,
              /make no mistake/,
              /does the trick/,
              /off and running/,
              /my way or the highway/ ]
  def number_of_cliches
    CLICHES.inject(0) do |count, phrase|
      count += 1 if phrase =~ content
      count 
    end
  end 
end

class Document1
  include WritingQuality

  attr_accessor :content

  def initialize 
    @content = 'make no mistake, I am off and running soon and quick'
  end

end 

describe Document do

  it 'test class' do
    doc = Document.new
    expect(doc.number_of_cliches).to eq(1)
  end

  it 'test mixin' do
    doc = Document1.new
    expect(doc.number_of_cliches).to eq(2)
    expect(doc.kind_of? WritingQuality)
    pp Document1.ancestors
  end

end