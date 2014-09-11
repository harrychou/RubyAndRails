def do_something 
  yield if block_given?
end

def do_something_with_arg (a, b)
  pp a 
  pp b
  yield if block_given?
end

def do_something_with_code_block_arg (a, b)
  yield a, b if block_given?
end

def each_word_pair (words)
  word_array = words
  index = 0
  while index < (word_array.size-1)
    yield word_array[index], word_array[index+1]
    index += 1
  end
end

class Document
  include Enumerable

  # Most of the class omitted...

  def each
    words = ['harry', 'chou', 'lala', 'rocks', 'yeah']
    words.each { |word| yield( word ) }
  end
end

describe do

  it 'calling code block' do

    do_something do
      puts "Hello from inside the block"
    end

    do_something_with_arg 'a', 'b' do
      puts "Hello from inside the block"
    end

    do_something_with_code_block_arg 'a', 'b' do |a, b|
      puts "Hello from inside the block " + a + b
    end

    do_something { puts "Hello from inside the block1" }

  end

  it 'iterate through something that is not a collection' do 
    words = ['harry', 'chou', 'lala', 'rocks', 'yeah']
    each_word_pair words do |first, second|
      puts "#{first}, #{second}"
    end 
  end

  it 'use Enumerable module' do
    doc = Document.new
    expect(doc.include?('harry')).to be true
    expect(doc.include?('23sdfsdfasd4no')).to be false
  end

end