require 'spec_helper'

describe Papermill, "GET /" do
  it 'should have an index action' do
    get '/'
    last_response.should be_ok
  end

  it 'should return the body' do
    get '/'
    last_response.body.should =~ /Welcome to Papermill/
  end
end

describe Papermill, "GET /search" do
  it 'should attempt to search' do
    Bunyan::Logger.should_receive(:find)
    get '/search'
  end
end
