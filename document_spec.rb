# bowling_spec.rb
require_relative 'document'

title = "My Doc"
author = "Harry Chou"
content = "This is a wonderful day"
doc = Document.new(title, author, content)

describe Document do
  it "can count words" do
    expect(doc.word_count).to eq(5)
  end    

  it "can read attributes" do
    expect(doc.title).to eq(title)
    expect(doc.author).to eq(author)
    expect(doc.content).to eq(content)
    doc.to_text
  end

  it "can write attributes" do

    new_title = 'New Title'
    new_author = 'New Author'
    new_content = 'Here comes the new content'

    doc.writable = true

    old_title = doc.title
    old_author = doc.author
    old_content = doc.content

    doc.title = new_title
    doc.author = new_author
    doc.content = new_content

    expect(doc.title).to eq(new_title)
    expect(doc.author).to eq(new_author)
    expect(doc.content).to eq(new_content)

  end 

end