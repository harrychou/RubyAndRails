class NilClass 

  def test_it 
    pp 'test it'
  end

end




describe do

  it 'test changing NilClass' do

    nil.test_it

  end

end