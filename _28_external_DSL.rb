require 'rexml/document'

class XmlRipper
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


class EzRipper
  def initialize( program_path )
    @ripper = XmlRipper.new
    parse_program(program_path)
  end
  def run( xml_file )
    @ripper.run( xml_file )
  end
  def parse_program( program_path )
    File.open(program_path) do |f|
      until f.eof?
        parse_statement( f.readline )
      end 
    end
  end

  def parse_statement( statement )
    statement = statement.sub( /#.*/, '' )
    case statement.strip
    when ''
      # Skip blank lines
    when /print\s+(.*?)/ 
      @ripper.on_path( $1 ) do |el|
        puts el.text
      end
    when /delete\s+(.*?)/
      @ripper.on_path( $1 ) { |el| el.remove }
    when /replace\s+(.*?)\s+'(.*?)'$/ 
      @ripper.on_path( $1 ) { |el| el.text = $2 }
    when /uppercase\s+(.*?)/
      @ripper.on_path( $1 ) { |el| el.text = el.text.upcase }
    when /print_document/
      @ripper.after do |doc|
        puts doc 
      end
    else
      raise "Don't know what to do with: #{statement}"
    end 
  end

#  def parse_statement( statement )
#    tokens = statement.strip.split
#    return if tokens.empty?
#    case tokens.first
#    when 'print'
#      @ripper.on_path( tokens[1] ) do |el|
#        puts el.text
#      end
#    when 'delete'
#      @ripper.on_path( tokens[1] ) { |el| el.remove }
#    when 'replace'
#      @ripper.on_path( tokens[1] ) { |el| el.text = tokens[2] }
#    when 'print_document'
#      @ripper.after do |doc|
#        puts doc 
#     end
#    else
#      raise "Unknown keyword: #{tokens.first}"
#    end 
#  end
end

describe do

  it 'use external DSL to update xml doc' do
    EzRipper.new('externalDSL.txt').run('fellowship.xml')
  end
end