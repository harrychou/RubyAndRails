class Document
  #attr_accessor :title, :author, :content  
  
  attr_accessor :writable
  attr_reader :title, :author, :content  
  
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

  def title= (new_title)
    @title = new_title if @writable
  end

  def author= (new_author)
    unless ! @writable
      @author = new_author
    end
  end

  def content= (new_content)
    unless not @writable
      @content = new_content
    end
  end

  def to_text
    puts ''
    puts '-----------------'
    puts "Title : #{@title}" # interpolation only for double quotes
    puts "Author : #{@author}"
    puts '-----------------'
    words.each { |word| puts word }
  end

end

