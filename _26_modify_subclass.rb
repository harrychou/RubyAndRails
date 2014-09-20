class Paragraph
  attr_accessor :font_name, :font_size, :font_emphasis
  attr_accessor :text
  def initialize( font_name, font_size, font_emphasis, text='')
    @font_name = font_name
    @font_size = font_size
    @font_emphasis = font_emphasis
    @text = text
  end
  def to_s
    @text
  end
  # Rest of the class omitted...
end

class StructuredDocument
  attr_accessor :title, :author, :paragraphs
  def initialize( title, author )
    @title = title
    @author = author
    @paragraphs = []
    yield( self ) if block_given?
  end

  def <<( paragraph )
    @paragraphs << paragraph
  end

  def content
    @paragraphs.inject('') { |text, para| "#{text}\n#{para}" }
  end

  # ... 
end

class Resume < StructuredDocument 
	def name( text )
    	paragraph = Paragraph.new( :nimbus, 14, :bold, text )
    	self << paragraph
	end
	def address( text )
		paragraph = Paragraph.new( :nimbus, 12, :italic, text ) 
		self << paragraph
	end
	def email( text )
		paragraph = Paragraph.new( :nimbus, 12, :none, text ) 
		self << paragraph
	end
	# and so on 
end

class Instructions < StructuredDocument
  paragraph_type( :introduction,
    :font_name => :arial,
    :font_size => 18,
    :font_emphasis => :italic )
  # And so on...

  def self.paragraph_type(paragraph_name, options)
  end
end

describe do

  it 'test structured document' do

	russ_cv = StructuredDocument.new( 'Resume', 'RO' ) do |cv|
		cv << Paragraph.new( :nimbus, 14, :bold, 'Russ Olsen' )
		cv << Paragraph.new( :nimbus, 12, :italic, '1313 Mocking Bird Lane') 
		cv << Paragraph.new( :nimbus, 12, :none, 'russ@russolsen.com')
	end

	pp russ_cv.content

  end

  it 'test creating resume' do
	russ_cv = Resume.new( 'russ', 'resume') do |cv|
		cv.name( 'Russ Olsen' )
		cv.address( '1313 Mocking Bird Lane' )
		cv.email( 'russ@russolsen.com' )
		# Etc... 
	end

	pp russ_cv.content
  end	
end