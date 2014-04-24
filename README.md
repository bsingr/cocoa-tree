![Cocoa Tree](./app/assets/images/cocoa-tree-320.png)

# Cocoa Tree

[![Build Status](https://travis-ci.org/bsingr/cocoa-tree.png)](https://travis-ci.org/bsingr/cocoa-tree)
[![Code Climate](https://codeclimate.com/github/bsingr/cocoa-tree.png)](https://codeclimate.com/github/bsingr/cocoa-tree)

This project is used to build [cocoa-tree.github.io](http://cocoa-tree.github.io), a CocoaPods browser inspired by the ruby toolbox.

In its core it is a single page application that totally lives in the browser. The [seeds repository](http://github.com/cocoa-tree/seeds) acts as a data backend and is rebuild every 24 hours by the [CocoaTreeSeeds rails application](http://github.com/bsingr/cocoa-tree-seeds).

## Deployment

First start the rails server in production mode:

    RAILS_ENV=production rails s

Then generate and deploy the site:

    RAILS_ENV=production rake assets:clean assets:precompile rails_zero:generate rails_zero:deploy:git

**Heroku**

Enable multi buildpacks via `.buildpacks`:

    heroku config:set BUILDPACK_URL=heroku config:add BUILDPACK_URL=https://github.com/ddollar/heroku-buildpack-multi.git

For phantomjs buildpack:

    heroku config:set PATH="/usr/local/bin:/usr/bin:/bin:/app/vendor/phantomjs/bin"
    heroku config:set LD_LIBRARY_PATH="/usr/local/lib:/usr/lib:/lib:/app/vendor/phantomjs/lib"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Copyright © 2013 - 2014 Jens Bissinger. This project uses [MIT-LICENSE](LICENSE.txt).

Logo made with :heart: by [fabric8](http://fabric8.de/).
