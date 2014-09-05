class DummySpec 
  # dummy
end

describe DummySpec do

  it "should do something" do
    pp 'abc'.class
    pp 'abc'.class.class
    pp 'abc'.class.class.class
    #pp false.class
    #pp /abc/.class
  end 

end 
