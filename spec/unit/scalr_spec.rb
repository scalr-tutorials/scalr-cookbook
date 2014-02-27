require 'spec_helper'
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut


describe Scalr do
  let(:node) do
    {}
  end

  let(:xml) do

  class MockShellOut
    attr_accessor :stdout

    def initialize(stdout)
      @stdout = stdout
    end
  end

    MockShellOut.new <<-eos
<?xml version="1.0" encoding="utf-8"?>
<response>
  <variables>
    <variable name="SCALR_INSTANCE_INDEX">1</variable>
    <variable name="SCALR_SERVER_TYPE">m1.small</variable>
    <variable name="SCALR_FARM_ROLE_ALIAS">hadoop-slave</variable>
  </variables>
</response>
    eos
  end

  before do
    Chef::Mixin::ShellOut.stub(:shell_out).and_return(xml)
  end

  describe 'global_variables' do

    it 'returns the variables when passed an empty node' do
      expect(Scalr.global_variables node).to eq({"SCALR_INSTANCE_INDEX"=> "1", "SCALR_SERVER_TYPE"=>"m1.small", 
                                                 "SCALR_FARM_ROLE_ALIAS"=>"hadoop-slave"})
    end

    it 'returns the variables when passed no node' do
      expect(Scalr.global_variables ).to eq({"SCALR_INSTANCE_INDEX"=> "1", "SCALR_SERVER_TYPE"=>"m1.small", 
                                             "SCALR_FARM_ROLE_ALIAS"=>"hadoop-slave"})
    end

  end

end
