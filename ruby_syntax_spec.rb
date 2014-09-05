class RubySyntax ; end

describe RubySyntax do

  it "2 plus 2 is four" do
    expect(2 + 2).to eq(4)
  end

  it "case statement" do

    # used as switch statement
    title = 'Clean Code'
    case title
    when 'War And Peace'
      puts 'Tolstoy'
    when 'Romeo And Juliet'
      puts 'Shakespeare'
    else
      puts "Don't know"
    end

    # used to assign value
    author = case title
             when 'War And Peace'
               'Tolstoy'
             when 'Romeo And Juliet'
               'Shakespeare'
             else
               "Don't know"
             end
    expect(author).to eq("Don't know")

    # meke it more compact
    author = case title
             when 'War And Peace' then 'Tolstoy'
             when 'Romeo And Juliet' then 'Shakespeare'
             else "Don't know"
             end 

    ruby = RubySyntax.new
    
    case ruby
    when RubySyntax
      puts 'it is RubySyntax'
    else 
      puts 'no no ...'         
    end

  end

  it "test truthy or falsy" do
    flag = 'something'

    puts 'flag is truthy' if flag == true
    puts 'flag is falsy' unless flag == true

  end

  it "generate collections from method call" do
    col = take_all_args 'test', 'this', 'works'
    col.each { |item| puts item }

    col = take_at_least_two 'one', 'two', 'three', 'four'
    # col = take_at_least_two 'one' 
    col.each { |item| puts item }

  end

  it "play with looping through hash" do
    movie = { title: '2001', genre: 'sci fi', rating: 10 }
    movie.each { |entry| pp entry }
  end

  it "try to call method with hash args" do
    link_to "Font", :controller =>"fonts", :action =>"show", :id =>123
  end 


  it 'test regular expression' do
    puts '----------------------------'
    pp /May/ =~ 'this is da'
    puts '----------------------------'
  end

end

def take_all_args ( *args )
  args
end

def take_at_least_two( first_arg, *middle_args, last_arg )
  [first_arg] + middle_args + [last_arg]
end

def link_to (name, *attributes)
  puts name
  pp attributes
end
