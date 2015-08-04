[![Circle CI](https://circleci.com/gh/Spantree/barker.svg?style=svg)](https://circleci.com/gh/Spantree/barker)

![Github Clone Screen Capture](slides/slides/images/barker-screenshot.png)

## What is Barker?

Barker is a Rails 4-based Twitter clone originally created by [Toshimaru](https://github.com/toshimaru/Rails-4-Twitter-Clone) to demonstrate how to build a basic Ruby on Rails application based on this [Ruby on Rails Tutorial](http://ruby.railstutorial.org/ruby-on-rails-tutorial-book). The original has been extended by [Spantree Technology Group, LLC] to show to to transform an traditional web application to support high availability on the cloud using tools like:

* [Consul](http://consul.io) for fault-tolerant and datacenter-aware service discovery, see [Diplomat](https://github.com/Spantree/barker/blob/5b409b914396e824a4b58aeed85d11cc24a8ba54/config/application.rb#L42-L57), [database](https://github.com/Spantree/barker/blob/5b409b914396e824a4b58aeed85d11cc24a8ba54/config/database.yml#L28-L38) and [docker-compose](https://github.com/Spantree/barker/blob/570a297e695196f0321e982e5751d710db5a6664/docker-compose.yml#L7-L10) configurations.
* [ELK](https://www.elastic.co/webinars/introduction-elk-stack) for distributed log aggregation, see [Rails logging](https://github.com/Spantree/barker/blob/5b409b914396e824a4b58aeed85d11cc24a8ba54/config/application.rb#L50-L56) and [docker-compose](https://github.com/Spantree/barker/blob/570a297e695196f0321e982e5751d710db5a6664/docker-compose.yml#L11-L17) configurations.
* [Packer](http://packer.io) for automated immutable AMI creation, see [packer folder](packer/) and [image provisioning shell scripts](system/scripts).
* [CircleCI](http://circleci.com) for continuous integration, see [circle.yml file](circle.yml) and [ci scripts](https://github.com/Spantree/barker/tree/develop/ci).
* [Asgard](https://github.com/Netflix/asgard) for zero-downtime rolling deployments to AWS, see [docker-compose](https://github.com/Spantree/barker/blob/570a297e695196f0321e982e5751d710db5a6664/docker-compose.yml#L18-L20) and [plugin](https://github.com/Spantree/barker/tree/develop/system/asgard) configurations.
* [Gatling](http://gatling.io) for stress testing, see [stress_tests folder](stress_tests).

## Presentation

There is an accompanying brower-based slide deck that walks through the motivations for this project and its architecture [here](http://bit.ly/hacloudapps).

## Attributions

* Toshimaru's Original [Rails 4 Twitter Clone](https://github.com/toshimaru/Rails-4-Twitter-Clone)
* TANABE Ken-ichi's [Circle CI Packer Example](https://github.com/nabeken/circleci-packer-example)
* [Jeff Smith's](https://twitter.com/jeffksmithjr) high-availability french bulldog illustrations
* [Paul Saskin](https://dribbble.com/shots/1074140-Pin-dog) "Pin Dog" concept mark