[![Circle CI](https://circleci.com/gh/Spantree/barker.svg?style=svg)](https://circleci.com/gh/Spantree/barker)

![Github Clone Screen Capture](https://cloud.githubusercontent.com/assets/803398/5903211/acdfe32c-a5c3-11e4-8171-b5ab2c3ef806.png)

## Implementation

This implementaton is based on [Ruby on Rails Tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book).

## Features

This application doesn't provide many features in order to keep it simple. Here are the features that it does include:

* See timeline
* Post new tweet
* Follow/Unfollow user

## Used gem

### For template
* slim

### Style
* bootstrap-sass

### For testing
* rspec
* factory_girl
* capybara
* simplecov
* guard
* faker

### For debugging
* quiet_assets
* bullet
* better_errors & binding_of_caller

See more details on [Gemfile](https://github.com/toshimaru/Rails-4-Twitter-Clone/blob/master/Gemfile).

## Test

    $ bundle exec rspec

## Data reset and creation

    $ bundle exec rake db:reset
    $ bundle exec rake db:populate
    $ bundle exec rake test:prepare

## TODO

* Add profile description to User
  * and Favorites feature
* User Slug
  * Edit user
  * Add spec
* Spec of pagination

## Attributions

* Toshimaru's Original [Rails 4 Twitter Clone](https://github.com/toshimaru/Rails-4-Twitter-Clone) (this project is a fork of that very awesome project)
* TANABE Ken-ichi's [Circle CI Packer Example](https://github.com/nabeken/circleci-packer-example)
