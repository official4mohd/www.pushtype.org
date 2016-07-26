---
title:    Fields
---

Custom field types are where the magic happens in PushType. By applying different fields to node objects, content can be modelled in boundless ways. A few lines of code, no database migrations, no forms to create - it just works!

## Adding fields to a node

Fields are added to a node class by calling the `field` class method. The field method accepts three arguments:

* `name` - the name of the attribute
* `type` - the field type, defaults to `:string`
* `options` - a hash of options

Take the following example:
  
    #!ruby
    # Model a Person object with a name, date of birth
    class Person < PushType::Node
      field :biography, :wysiwyg, validates: { presence: true }
      field :date_of_birth, :date
    end
    
    # Lets create a person
    me = Person.new title: 'John Doe', date_of_birth: '1954-02-25'
    
    me.title          #=> "John Doe"
    me.date_of_birth  #=> #<Date: 1954-02-25>
    me.valid?         #=> false

So far, so predictable. But here's where it gets cool:

1. Data is stored internally in a JSON object so it's possible to create deep and complex data structures with no database migrations.
2. Each field type has it's own template and other UI assets, so PushType automatically creates forms for editing your nodes.
3. If PushType's built in set of custom fields don't quite offer the flexibility you need, then it's simple to customise the behaviour of existing fields or even build your own!


## Available field types

<div class="panel callout warning">
  <h3>Incomplete documentation</h3>
  <p>We're working on this section of the documentation. The example below shows all of the field types built in to PushType.</p>
</div>

    #!ruby
    class Page < PushType::Node

      # Basic field types
      field :basic_1, :string   # => Provides a text field
      field :basic_2, :text     # => Provides a textarea
      field :basic_3, :wysiwyg  # => Provides a WYSIWYG editor
      field :basic_4, :markdown # => Provides a Markdown editor, renders the value as HTML
      field :basic_5, :number   # => Provides a number field
      field :basic_6, :boolean  # => Provides a checkbox
      field :basic_7, :date     # => Provides a datepicker
      field :basic_8, :time     # => Provides a timepicker

      # Select fields provide a select box
      field :sel_1, :select, choices: ['foo', 'bar', 'baz']
      # Can also accept choices as a proc
      field :sel_2, :select, choices: -> { Tag.all.map(&:name) }, multiple: true

      # Tag lists
      field :tags, :tag_list

      # Repeating fields allow many values to be added which are stored
      # internally as an Array
      field :notes, :repeater, repeats: :text
      field :contacts, :matrix do
        field :name, :string
        field :age, :number
      end

      # Relation fields create associations
      # The name of the field *must* end in `_id`, and the relation class
      # is assumed from the field name
      field :article_id, :relation # => Associates with `Article` class
      # Although the relation class can be passed with the to option
      field :foo_id, :relation, to: :article, scope: -> { published }

      # The asset field is a kind of relation field
      field :image, :asset      # => Provides  an asset picker

      # Structure fields allow classes with their own logic to be embeded as fields
      field :person, :structure do
        field :name, :string
        field :age, :number

        def adult?
          age && age >= 18
        end
      end

    end
