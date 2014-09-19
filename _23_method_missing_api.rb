class FormLetter 
  attr_accessor :content

  def replace_word( old_word, new_word )
    @content.gsub!( old_word, "#{new_word}" )
  end


  def method_missing( name, *args )
    string_name = name.to_s
    return super unless string_name =~ /^replace_\w+/
    old_word = extract_old_word(string_name)
    replace_word( old_word, args.first )
  end

  def extract_old_word( name )
    name_parts = name.split('_')
    name_parts[1].upcase
  end

end




describe do

  it 'try gsub way' do

    doc = FormLetter.new
    doc.content = %q{
        Dear Mr. LASTNAME
        Are you troubled by the heartache of hangnails?
        ...
        FIRSTNAME, we look forward to hearing from you.
    }

    doc.replace_word("FIRSTNAME", 'Harry')
    doc.replace_word("LASTNAME", 'Chou')

    pp doc.content

  end

  it 'use method missing to capture it' do

    doc = FormLetter.new
    doc.content = %q{
        Dear Mr. LASTNAME
        Are you troubled by the heartache of hangnails?
        ...
        FIRSTNAME, we look forward to hearing from you.
    }

    doc.replace_firstname 'Isaac'
    doc.replace_lastname 'Awesome'

    pp doc.content
    

  end

end