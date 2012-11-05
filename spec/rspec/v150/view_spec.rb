require 'rspec/v150/view'

describe RSpec::V150::View do
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

  it 'responds to page' do
    view_spec.should respond_to(:page)
  end

  it 'renders a simple view' do
    view_spec.stub(:template_source) { 'Hello <%= "World" %>' }
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

  describe 'geting template_path from excample_group description' do
    let(:example_group) { double(:top_level_description => 'post/index') }
    let(:example) { double(:example_group => example_group) }

    it "get's the template_path from the example_group" do
      view_spec.stub(:example => example)
      view_spec.template_path.should == 'app/views/post/index.html.erb'
    end
  end

  it 'finds a full path template' do
    view_spec.template = 'post/index.html.erb'
    view_spec.template_path.should == 'app/views/post/index.html.erb'
  end

  it 'finds the full path from a partial path template' do
    view_spec.template = 'post/index'
    view_spec.template_path.should == 'app/views/post/index.html.erb'
  end

  it "set's page as a Capybara version of rendered" do
    rendered = double
    view_spec.stub(:rendered => rendered)
    Capybara.should_receive(:string).with(rendered)
    view_spec.page
  end

  describe 'rendering views that render other views' do
    it 'renders the template' do
      view_spec.view.should_receive(:render).with(:partial => 'other_template')
      view_spec.stub(:template_path => 'spec/files/views/post/rerendering.html.erb' )
      view_spec.template = 'post/rerendering'
      view_spec.render
    end
  end

  it 'renders link_to as expected by rails for string_paths' do
    view_spec.stub :template_source => '<%= link_to "Here is the post", "/post" %>'
    view_spec.render
    view_spec.rendered.should == '<a href="/post">Here is the post</a>'
  end

  it 'renders link_to as expected by rails for stubed out routes' do
    view_spec.stub :template_source => '<%= link_to "Here is the post", post_path %>'
    view_spec.view.stub(:post_path => '/post')
    view_spec.render
    view_spec.rendered.should == '<a href="/post">Here is the post</a>'
  end

end
