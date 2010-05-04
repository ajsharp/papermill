require 'spec_helper'

describe 'papermill' do
  it 'should have an index action' do
    get '/'
    last_response.should be_ok
  end

  it 'should return the body' do
    get '/'
    last_response.body.should =~ /Welcome to Papermill/
  end
end
