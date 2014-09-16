class SimpleBaseClass
  def self.inherited( new_subclass )
    puts "Hey #{new_subclass} is now a subclass of #{self}!"
  end
end

class ChildClassOne < SimpleBaseClass
end

class Document 
  def initialize(title, author, content)
  end 
end

class DocumentReader

  class << self
    attr_reader :reader_classes
  end

  @reader_classes = []

  def self.read(path)
    reader = reader_for(path)
    return nil unless reader
    reader.read(path)
  end

  def self.reader_for(path)
    reader_class = DocumentReader.reader_classes.find do |klass|
      klass.can_read?(path)
    end
    return reader_class.new(path) if reader_class
    nil
  end

  # One critical bit omitted, but stay tuned...
  def self.inherited(subclass)
    DocumentReader.reader_classes << subclass
  end

end

class PlainTextReader < DocumentReader
  def self.can_read?(path)
    /.*\.txt/ =~ path
  end
  def initialize(path)
    @path = path
  end
  def read(path)
    File.open(path) do |f|
      title = f.readline.chomp
      author = f.readline.chomp
      content = f.read.chomp
      Document.new( title, author, content )
    end
  end
end

class YAMLReader < DocumentReader
  def self.can_read?(path)
    /.*\.yaml/ =~ path
  end
  def initialize(path)
    @path = path
  end
  def read(path)
    # Lots of simple YAML stuff omitted
  end
end

class XMLReader < DocumentReader
  def self.can_read?(path)
    /.*\.xml/ =~ path
  end
  def initialize(path)
    @path = path
  end
  def read(path)
    # Lots of complicated XML stuff omitted
  end
end


module WritingQuality
  def self.included(klass)
    puts "Hey, I've been included in #{klass}"
  end
  def self.extended(klass)
    puts "Hey, I've been extended in #{klass}"
  end
  def number_of_cliches
    # Body of method omitted...
  end 
end

class ClassA
  include WritingQuality
end

class ClassB
  extend WritingQuality
end


describe do

  it 'try hook' do
    #do_something
  end

  it 'document reader example' do 

  end

end