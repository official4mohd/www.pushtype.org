---
title:    Key concepts
comments: true
---

A core philosophy behind PushType is the belief that the most efficient and effective way for a developer to design and build a site is through writing code.

We use this principle to justify a more streamlined and simpler user interface. We give the website owner the right tools to manage their site on a day-to-day basis. We give the developer a turbo-charged set of power tools only accessible under the hood.

A website's content hierarchy and underlying structure is defined with code and classes, following simple and reusable patterns. The result is an extremely efficient and flexible system where content can be bent and moulded in ways limited only by your imagination.

PushType encourages you to get your hands dirty with code. It encourages you to **hack, tinker and learn**.

## Content tree

Content in PushType is arranged in a tree-like hierarchy of **nodes**. There can be many different types of node, and these can be nested into deep and complex structures of content.

::TODO - illustration::

## Nodes

A node is simply a class that inherits from `PushType::Node`. Each node also has it's own view. By default the `NodesFrontEndController` will render a node's view when you visit the node's permalink.

It's also possible to create *unexposed* nodes. This allows you to create content within the tree that is effectively hidden to the front end, but can be referenced and used elsewhere in the site.

As a node is just a model in your Rails app, the behaviour of that node can be manipulated by writing plain old Ruby. Of course the most common thing you'll wan't to do is add custom fields to your content, and that is breathtakingly simple:

    #!ruby
    class Article < PushType::Node
      field :body, :wysiwyg, validates: { presence: true }
      field :tags, :tag_list
      field :author, :select, choices: -> { Author.all.map { |a| [a.name, a.id] } }
    end

## Custom fields

PushType comes jam-packed with a built-in set of useful field types, from the humble text field to our wysiwyg editor, from asset pickers to date pickers.

It won't be long before you'll want to write your own custom fields. That's made easy too. Fields are classes that inherit from `PushType::Field` and can also have their own view and assets. With not a lot of effort, you can create immensely powerful field types that behave exactly how you need them to behave.

## What next?

These three concepts - the tree-like content hierarchy, the custom node types and custom field types - combine to create an infinitely flexibly system. Complex structures of content can be thrown together with just a few lines of code and a few more minutes work.

* [Learn more about nodes](/docs/nodes)
* [Learn more about custom fields](/docs/fields)