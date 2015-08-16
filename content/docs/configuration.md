---
title:    Configuration
comments: true
---

When you invoke `rails g push_type:install` during [Installation](/docs/installation), an initializer file is generated and saved to `config/initializers/push_type.rb`. This file can be used to configure various aspects of your PushType installation.

## Root nodes

By default all node types can be placed at the root of the [content tree](/docs/key-concepts#content-tree). Instead this can be whitelisted by passing an array of node type symbols to the `root_nodes` option.

    #!ruby
    # Restrict root nodes to HomePage and Page node types
    config.root_nodes = [:home_page, :page]

## Homepage

By default, when visiting the root URL of your PushType site (the homepage), the `NodesFrontEndContoller` will look for a node with the slug `home`. This behaviour can be changed by setting a different value for the `home_slug` option.

    #!ruby
    # Set the homepage slug
    config.home_slug = 'landing_page'

The config setting can be overridden in `config/routes.rb` by passing the `:home` option:

    #!ruby
    mount_push_type home: 'blog'

## Unexposed nodes

By default all node types are exposed to the `NodesFrontEndController` when visiting the permalink. Sections of content can be blacklisted (and effectively hidden) from the front end by passing an array of node type symbols to the `unexposed_nodes` option.

    #!ruby
    # Hide node types from the NodesFrontEndController
    config.unexposed_nodes = [:testimonial, :author_profile]

It's also possible to add a node type to the unexposed nodes list by calling `Node.unexpose!` on the class itself:

    #!ruby
    class Testimonial < PushType::Node
      unexpose!
    end

## Unexposed taxonomies

By default all taxonomy terms are exposed to the `TaxonomiesFrontEndController` when visiting the permalink. Whole taxonomies can be blacklisted from the front end by passing an array of taxonomy type symbols to the `unexposed_taxonomies` option.

    #!ruby
    # Hide taxonomies from the NodesFrontEndController
    config.unexposed_taxonomies = [:manufacturer, :author]

Hey guess what? We can also add taxonomies to the unexposed taxonomies list by calling `Taxonomy.unexpose!` on the class itself:

    #!ruby
    class Manufacturer < PushType::Taxonomy
      unexpose!
    end

## Media styles

Media styles allow you to configure a collection of reusable [geometry strings](http://markevans.github.io/dragonfly/imagemagick/#processors) to be used by the `Asset#media` method for resizing images on the fly. The built in WYSIWYG editor makes use of these to allow users to easily scale images to predefined sizes.

    #!ruby
    # Set predefined geometry strings for resizing image assets
    config.media_styles = {
      large:    '1024x1024>',
      medium:   '512x512>',
      small:    '256x256>'
    }

    # And use them with Asset#media
    image.media(:medium)

## Dragonfly datastore

PushType uses [Dragonfly](http://markevans.github.io/dragonfly/) for managing uploaded images/assets. By default uploads are stored on the filesystem but it's simple to switch to any datastore.

    #!ruby
    # Dragonfly datastore configuration
    config.dragonfly_datastore = :file
    config.dragonfly_datastore_options = {
      root_path:    Rails.root.join('public/system/dragonfly', Rails.env),
      server_root:  Rails.root.join('public')
    }
      
    # For S3 storage, remember to add to Gemfile:
    # gem 'dragonfly-s3_data_store'
    config.dragonfly_datastore = :s3
    config.dragonfly_datastore_options = {
      bucket_name:        ENV['S3_BUCKET'],
      access_key_id:      ENV['S3_ACCESS_KEY_ID'],
      secret_access_key:  ENV['SECRET_ACCESS_KEY_ID']
    }

