require 'rspec/v150/view/context'

describe RSpec::V150::View::Context do
  it 'requires all of its dependencies' do
    RSpec::V150::View::Context.new.class.should be(RSpec::V150::View::Context)
  end
end
