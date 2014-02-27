require 'spec_helper'

describe Scalr do
  let(:node) do
    { :scalr => { :override_gv => {'k1' => 1, 'k2' => 2} } }
  end

  describe 'global_variables_override' do
    it 'returns Global Variables from the override' do
      expect(Scalr.global_variables node).to eq({"k1"=>1, "k2"=>2})
    end
  end

end
