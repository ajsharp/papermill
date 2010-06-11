require 'spec_helper'

describe Papermill::Paul, ".search" do
  it 'should wrap bunyan' do
    Bunyan::Logger.should_receive(:find)
    Papermill::Paul.search
  end

  it 'should not do a regex search when search for the status code' do
    params = { 
      'search-fields' => ['user.email', 'status'], 
      'search-values' => ['asharp', '200'] 
    }
    Bunyan::Logger.should_receive(:find).with({'user.email' => /asharp/, 'status' => 200}, :limit => 100, :sort => ['$natural', -1])
    Papermill::Paul.search(params)
  end
end
