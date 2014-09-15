def do_something (&that_block)
  puts "about to run the block"
  that_block.call if that_block
  puts "done running the block"
end


class DocumentSaveListener
  def on_save( doc, path)
    puts "Hey, I've been saved!"
  end
end

class DocumentLoadListener
  def on_load( doc, path)
    puts "Hey I've been loaded!"
  end
end

class Document
  # Most of the class omitted...
  def on_save( &block )
    @save_listener = block
  end
  def on_load( &block )
    @load_listener = block
  end
  def load( path )
    #@content = File.read( path )
    @load_listener.call( self, path ) if @load_listener
  end
  def save( path )
    #File.open( path, 'w' ) { |f| f.print( @contents ) }
    @save_listener.call( self, path ) if @save_listener
  end
end

class ArchivalDocument
  attr_reader :title, :author

  def initialize(title, author, path)
    @title = title
    @author = author
    @path = path
  end

  def content
    @content ||= File.read( @path )
  end
end

class BlockBasedArchivalDocument
  attr_reader :title, :author
  def initialize(title, author, &block)
    @title = title
    @author = author
    @initializer_block = block
  end
  def content
    if @initializer_block
      @content = @initializer_block.call
      @initializer_block = nil
    end
    @content
  end
end


describe do

  it 'try execute around' do
    do_something
  end

  it 'try using code block as listeners' do 
    doc = Document.new
    doc.on_load do |doc, path| 
      puts "loaded ...." << path
    end
    doc.on_save do |doc|
      puts "saved ...."
    end

    doc.save('test.txt')
    doc.load('test.txt')
    doc.save('test.txt')
  end

end