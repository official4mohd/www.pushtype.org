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

So far, so predictable. But here's where it get cool:

1. Data is stored internally in a JSON object so it's possible to create deep and complex data structures with no database migrations.
2. Each field type has it's own template and other UI assets, so PushType automatically creates forms for editing your nodes.
3. If PushType's built in set of custom fields don't quite offer the flexibility you need, then it's simple to customise the behaviour of existing fields or even build your own!


<div class="panel callout warning">
  <h3>Incomplete documentation</h3>
  <p>We're working on this section of the documentation. It'll be with you soon.</p>
</div>
