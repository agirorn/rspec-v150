require 'rspec/v150/view'

describe RSpec::V150::View do
  let(:simple_template) { 'Hello <%= "World" %>' }
  let(:example_group) { double(:top_level_description => 'post/index') }
  let(:example) { double(:example_group => example_group) }

  let(:view_spec) do
    Class.new do
      include RSpec::V150::View
    end.new
  end

  it 'responds to view' do
    view_spec.should respond_to(:view)
  end

  it 'responds to render' do
    view_spec.should respond_to(:render)
  end

  it 'responds to rendered' do
  end

  it 'renders a simple view' do
    view_spec.view.stub(:template) { simple_template }
    view_spec.render
    view_spec.rendered.should == 'Hello World'
  end

  it 'asks rspec for the template name' do
    view_spec.stub(:example => example)
    view_spec.template.should == 'post/index'
  end

  it "set's instance varables for the view" do
    post = double
    view_spec.assign(:post, post)
    view_spec.view.instance_variable_get(:@post).should eq(post)
  end

end
