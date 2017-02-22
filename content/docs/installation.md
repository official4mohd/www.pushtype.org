---
title:    Installation
subtitle: Get started and install the PushType RubyGem.
priority: 0.6
comments: true
---

This tutorial will guide you through the simple process of installing PushType in to your Rails application.

## Dependencies

PushType takes advantage of modern features of PostgreSQL, which in turn requires a recent version of Rails.

* Rails 4.2+
* PostgreSQL 9.4, as well as the [contrib modules](https://www.postgresql.org/docs/9.1/static/contrib.html) for the [uuid-ossp extension](https://www.postgresql.org/docs/9.1/static/uuid-ossp.html)
* ImageMagick

## Installation

Assuming you have a Rails app ready to go, add the following line to the `Gemfile`:

    #!ruby
    gem 'push_type'

Then execute from the terminal:

    #!shell
    bundle install

Once bundler has done its thing, you'll be able to use PushType's Rails generators. Execute from the terminal:

    #!shell
    rails g push_type:install

That will install a [configuration file](/docs/configuration) in `config/initializers`, setup some rules is `config/routes.rb`, and migrate your database.

Finally, from the terminal run this rake task to create a user with which you'll be able to log in to PushType:

    #!shell
    rake push_type:create_user

## What next?

I'm guessing that didn't even take five minutes, right?

At this point, you can fire up your application and start poking around in the admin UI:

    http://localhost:3000/admin

However, you won't be able to create any content yet. You need to start generating node types.

* [Understand the key concepts behind PushType](/docs/key-concepts)
* [Generate your first node type](/docs/nodes)
