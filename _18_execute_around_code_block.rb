def do_something
  test = 'test'
  with_logging("do_something_before"){ puts 'doing something' << ' - ' << test}
end


def with_logging(description) 
  begin
    logger_debug( "Starting #{description}" )
    yield 
    logger_debug( "Completed #{description}" )
  rescue
    logger_debug( "#{description} failed!!")
    raise 
  end
end


def logger_debug(msg)
  
  puts '---------------------------'
  puts msg
  puts '---------------------------'

end




describe do

  it 'try execute around' do
    do_something
  end

end