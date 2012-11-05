rspec-v150
==========

Super Fast RSpec-2 for Rails-3


## Install

Add this to the Gemfile

```ruby
gem "rspec-v150", :git => "git://github.com/agirorn/rspec-v150.git"
```

Or this

```ruby
group :test do
  gem "rspec-v150", :git => "git://github.com/agirorn/rspec-v150.git"
end
```


### Configure

To be continued....

### View Specs

```erb
<h1><%= @post.title %></h1>
```

```ruby
require 'spec_helper'
require 'rspec/v150/view'

describe "post/index" do
  include Rspec::V150::View

  it "displays post title" do
    post = double(:title => 'Title of a Post')
    assign(:post, post)
    render
    page.should include('Title of a Post')
  end
end
```

```bash
time rspec spec/view/post/index.html.erb_spec.rb
.

Finished in 0.02694 seconds
1 examples, 0 failures
```

