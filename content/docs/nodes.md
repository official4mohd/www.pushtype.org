---
title:    Nodes
comments: true
---

Nodes are the building blocks of a PushType website. On it's own, a node is a  just a piece of content with a title and permalink. But each node can have siblings or children, so collectively nodes can be arranged to define a tree-like hierarchy of content.

It's tempting to think of nodes as pages, which in a way they are, but they can be so much more. A node can be an article, or an event, or a testimonial, or a promotion, or whatever your unique set of requirements demand.

## Creating a node

PushType ships with a Rails generator for creating new nodes. It is invoked by passing a name for the node along with a list of field names and field types.

rails g push_type:node page description:string body:wysiwyg

The generator will create a model at `app/models/page.rb`, which looks like:

    #!ruby
    class Page < PushType::Node

      # By default a node can have children of any other node type.
      # Optionally pass a list of acceptable node types or prevent
      # any descendants by passing false.
      has_child_nodes :all

      # Set custom fields
      field :description, :string
      field :body, :wysiwyg

    end

The generator also created a view at `app/views/nodes/page.rb` which is rendered by the `NodesFrontEndController` when you visit the node's permalink.

## Child nodes

By default a node can have children of any other node type. In most cases this is probably undesirable. The `has_child_nodes` class method can be used to whitelist acceptable children, or prevent descendants from the node entirely.

For example, a typical blog structure might look like this:

    #!ruby
    class Blog < PushType::Node
      has_child_nodes :article, order: :blog
    end

On any node instance, `Node#children` can be called to return all the children. By default children are ordered by the `sort_order` database column (essentially meaning that nodes can be ordered arbitrarily through the admin UI). This behaviour can be overridden by passing an SQL fragment   to the `:order` option.

Note that in the example above, the `:order` option contains the symbol `:blog`. This is a bit of PushType shorthand magic, essentially translating as `['published_at DESC', 'created_at DESC']`

## Custom fields

Custom fields are where PushType really begins to flex its muscles. The `field` class method can be called any number of times, passing the field name, the field type and an optional hash of options for the field type.

For example, an article in our blog might look like this:

    #!ruby
    class Article < PushType::Node
      field :excerpt, :text
      field :body, :wysiwyg, validates: { presence: true }
      field :categories, :taxonomy, multiple: true
      field :tags, :tag_list
    end

Hopefully the above is all pretty self explanatory. The real beauty is that this is all there is to it. Each field has it's own view so the admin UI will automatically render a rich form for your nodes. And because all field data is stored as as `jsonb` object in the PostgreSQL database, there are no migrations to run.

Custom fields are an incredibly powerful way to shape and model content. PushType comes packaged with a [wide variety of custom field types](/docs/fields) each with different options and capabilities.

## Unexposed nodes

By default all node types are exposed to the `NodesFrontEndController` when visiting the permalink. Sometimes it may be desirable to effectively hide sections of content from the front end. This can be achieved by calling the `unexpose!` class method on the node model.

For example, you may have a collection of testimonials that are stored in the content tree, but only ever embedded within other pieces of content (i.e. the testimonial shouldn't be an HTML document available through it's own permalink). Simples:

    #!ruby
    class Testimonial < PushType::Node
      unexpose!
    end

For those that are paying attention, this is exactly the same as adding the node type to the `unexposed_nodes` [configuration option](/docs/configuration#unexposed-nodes).
