class Document
  def method_missing (method_name, *args)
    puts "try to call a non-existing method : #{method_name}"
    puts "with args: #{args.join(' ')}" 
  end

  def self.const_missing( const_name ) 
    msg = %Q{
      You tried to reference the constant #{const_name}
      There is no such constant in the Document class.
    }
    puts msg
    #raise msg 
  end

end

class NilClass
  def method_missing(method_name)
    puts "calling #{method_name} on NilClass"
  end
end

  def self.const_missing( const_name ) 
    msg = %Q{
      You tried to reference the constant #{const_name}
      There is no such constant in the Document class.
    }
    puts msg
    #raise msg 
  end

describe do

  it 'try method missing' do
    doc = Document.new
    doc.test('a', 'b')
    doc.nonsense
  end

  it 'try constant missing' do
    Document::CONSTANT_A
    ConstantA
  end

  it 'whiny nil' do
    #nil.test
  end

end