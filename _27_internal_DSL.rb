require 'rexml/document'

class XmlRipper
  def initialize(&block)
    @before_action = proc {}
    @path_actions = {}
    @after_action = proc {}
    block.call( self ) if block
  end
  def on_path( path, &block )
    @path_actions[path] = block
  end
  def before( &block )
    before_action = block
  end
  def after( &block )
    @after_action = block
  end
  def run( xml_file_path )
    File.open( xml_file_path ) do |f|
      document = REXML::Document.new(f)
      @before_action.call( document )
      run_path_actions( document )
      @after_action.call( document )
    end
  end
  def run_path_actions( document )
    @path_actions.each do |path, block|
      REXML::XPath.each(document, path) do |element|
        #puts path + "....." 
        block.call( element )
      end
    end
  end
end

class XmlRipper1
  def initialize()
    @before_action = proc {}
    @path_actions = {}
    @after_action = proc {}
  end

  def initialize_from_file( path )
    instance_eval( File.read( path ) )
  end

  def on_path( path, &block )
    @path_actions[path] = block
  end
  def before( &block )
    before_action = block
  end
  def after( &block )
    @after_action = block
  end
  def run( xml_file_path )
    File.open( xml_file_path ) do |f|
      document = REXML::Document.new(f)
      @before_action.call( document )
      run_path_actions( document )
      @after_action.call( document )
    end
  end
  def run_path_actions( document )
    @path_actions.each do |path, block|
      REXML::XPath.each(document, path) do |element|
        #puts path + "....." 
        block.call( element )
      end
    end
  end


  def method_missing( name, *args, &block )
    return super unless name.to_s =~ /on_.*/
    parts = name.to_s.split( "_" )
    parts.shift
    xpath = parts.join( '/' )
    on_path( xpath, &block  )
  end
  
end


describe do

  it 'test parsing XML document' do

    File.open( 'fellowship.xml' ) do |f|
      doc = REXML::Document.new(f)
      author = REXML::XPath.first(doc, '/document/author')
      puts author.text

      REXML::XPath.each(doc, '/document/chapter/title') do |title|
        puts title.text
      end

      REXML::XPath.each(doc, '/document/author') do |author|
        author.text = 'J.R.R. Tolkien'
      end
      puts doc

    end

  end

  it 'use XMLRipper class' do 
    ripper = XmlRipper.new do |r|
      r.on_path( '/document/author' ) { |a| puts "AUTHOR: " << a.text }
      r.on_path( '/document/chapter/title' ) { |t| puts t.text }

      r.on_path( '/document/author' ) do |author|
        author.text = 'J.R.R. Tolkien'
      end
      r.after { |doc| 
        puts "================================"
        puts doc 
        puts "================================"
      }
    end
    ripper.run( 'fellowship.xml' )
  end

  it 'use internal DSL to update xml doc' do
    r = XmlRipper1.new
    r.initialize_from_file( 'internalDSL.txt' )
    r.run( 'fellowship.xml')
  end
end