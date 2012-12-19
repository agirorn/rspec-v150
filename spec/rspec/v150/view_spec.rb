require 'ostruct'
require 'rspec/v150/view'

describe RSpec::V150::View do
  class ViewSpec
    include RSpec::V150::View

    def example
      OpenStruct.new(
        :example_group => OpenStruct.new(:top_level_description => 'post/index')
      )
    end
  end

  module SomeHelper
    def some_helper_method
      'some help full text'
    end
  end

  let(:view_spec) { ViewSpec.new }
  let(:view) { view_spec.view }

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
    it "get's the template_path from the example_group" do
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

  it 'finds the full path for difrent types of files' do
    view_spec.template = 'post/index.text'
    view_spec.template_path.should == 'app/views/post/index.text.erb'
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

  describe 'Broken template' do
    it 'throws an ArgumentError when instance_variable is missing' do
      view_spec.stub(:template_path => 'spec/files/views/post/broken_instance_varabale.html.erb')
      expect { view_spec.render }.to raise_error(ArgumentError)
    end

    describe 'backtrace' do
      before do
        view_spec.stub(:template_path => 'spec/files/views/post/broken_instance_varabale.html.erb')
        begin
          view_spec.render
        rescue => boom
          line = boom.backtrace.first
          @file, @line_number, meth = line.split(":")
        end
      end

      it 'includes the template file name' do
        expect(@file).to eq('spec/files/views/post/broken_instance_varabale.html.erb')
      end

      it 'includes the template line number' do
        expect(@line_number).to eq('3')
      end
    end
  end

  it 'supports the capture_helper' do
    view_spec.stub :template_source => %{
      <%= capture do %>
        <p> <%= @message %> </p>
      <% end %>
    }
    view_spec.assign :message, 'THE MESSAGE'
    view_spec.render
    view_spec.rendered.strip.should == '<p> THE MESSAGE </p>'
  end

  it 'renders with out error when image_tag is used' do
    view_spec.stub :template_source => "<%= image_tag 'logo.jpeg' %>"
    view_spec.render
    view_spec.rendered.should == "<img src='logo.jpeg'>"
  end

  it 'can include other helpers' do
    view_spec.helper SomeHelper
    view.some_helper_method.should == 'some help full text'
  end

end
