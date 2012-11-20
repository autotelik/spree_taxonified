SpreeTaxonified
===============

## Installation

Add this extension to your Gemfile:

```ruby 
gem "spree_taxonified", :git => "https://github.com/autotelik/spree_taxonified.git"
 ```


Then run:
```ruby 
bundle install
rake spree_taxonified:install:migrations 
rake db:migrate
```


Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    bundle
    bundle exec rake test_app
    bundle exec rspec spec


Copyright (c) 2012 [Thomas Statter for www.autotelik.co.uk], released under the New BSD License
