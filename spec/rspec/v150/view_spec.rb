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
    view_spec.should respond_to(:rendered)
  end

  it 'renders a simple view' do
    view_spec.stub(:template_path)
    view_spec.view.stub(:template) { simple_template }
    view_spec.render
    view_spec.rendered.should == 'Hello World'
  end

  it "set's instance varables for the view" do
    post = double
    view_spec.assign(:post, post)
    view_spec.view.instance_variable_get(:@post).should eq(post)
  end

  it 'renders template from file' do
    view_spec.stub(:template_path => 'spec/files/views/post/index.html.erb')
    view_spec.render
    view_spec.rendered.should == "<h1> Template: post/index </h1>\n"
  end

  describe 'locating template' do
    it 'asks rspec for the template name' do
      view_spec.stub(:example => example)
      view_spec.template_path.should == 'app/views/post/index.html.erb'
    end

    it 'finds a full path template' do
      view_spec.template = 'post/index.html.erb'
      view_spec.template_path.should == 'app/views/post/index.html.erb'
    end

    it 'finds a partial path template' do
      view_spec.template = 'post/index'
      view_spec.template_path.should == 'app/views/post/index.html.erb'
    end
  end

end
