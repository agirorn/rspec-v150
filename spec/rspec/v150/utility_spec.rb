require 'rspec/v150/utility'
describe RSpec::V150::Utility do
  describe "detecting ActionPack Version" do
    module FackeActionPackVersion_3_0_20
      MAJOR = 3
      MINOR = 0
      TINY  = 20
      PRE   = nil

      STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
    end

    it "knows how to detect version 3.0" do
      stub_const("ActionPack::VERSION", FackeActionPackVersion_3_0_20)
      match = RSpec::V150::Utility.action_pack_version?('3.0')
      expect(match).to be(true)
    end

    it "knows how to exclude version 3.1 when running on 3.0" do
      stub_const("ActionPack::VERSION", FackeActionPackVersion_3_0_20)
      match = RSpec::V150::Utility.action_pack_version?('3.1')
      expect(match).to be(false)
    end
  end
end
