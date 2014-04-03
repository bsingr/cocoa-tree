![Cocoa Tree](./app/assets/images/cocoa-tree-320.png)

# Cocoa Tree

[![Build Status](https://travis-ci.org/dpree/cocoa-tree.png)](https://travis-ci.org/dpree/cocoa-tree)
[![Code Climate](https://codeclimate.com/github/dpree/cocoatree.png)](https://codeclimate.com/github/dpree/cocoatree)

## Deployment

First start the rails server in production mode:

    RAILS_ENV=production rails s

Then generate and deploy the site:

    RAILS_ENV=production rake assets:clean assets:precompile rails_zero:generate rails_zero:deploy:git

## TODO

* use web worker to generate HTML from mpac
* * Loading / Parsing the List via AJAX (once per session)
* * Updating the Indexddb with remote data?
* * Sorting / Filtering the List
* * Rendering a Range of the List
* build categories system
* categorize each pod manually

## Installation

Add this line to your application's Gemfile:

    gem 'cocoatree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cocoatree

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/dpree/cocoatree/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

This project uses [MIT-LICENSE](LICENSE.txt).

Logo made with :heart: by [fabric8](http://fabric8.de/).
