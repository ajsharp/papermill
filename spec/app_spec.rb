require 'spec_helper'

describe Papermill::App, "GET /" do
  it 'should have an index action' do
    get '/'
    last_response.should be_ok
  end
end

describe Papermill::App, "GET /search" do
  it 'should attempt to search' do
    Papermill::Paul.should_receive(:search)
    get '/search'
  end
end

describe Papermill::App, "GET /stats.json" do
  it 'should return a json response' do
    get '/stats.json'
    last_response.headers['Content-Type'].should == 'application/json'
  end

  it 'should be successful' do
    get '/stats.json'
    last_response.should be_ok
  end

  it 'should get stats from paul' do
    Papermill::Paul.should_receive(:stats)
    get '/stats.json'
  end
end
