# Raspy

Raspy provides an alternative to define and prefetch associations or relations between ActiveRecord models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'raspy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install raspy

## Usage

Here is a simple example:

```ruby
class User < ActiveRecord::Base
  include Rusql
  
  def permissions
    query = select( distinct( Permission[:name] ) ).
    from( Permission ).
    left_outer_join( user_permissions, user_permissions[:permission_id].equals( Permission[:id] ) ).
    left_outer_join( User, User[:id].equals( user_permissions[:user_id] ) ).
    where( User[:id].equals(self.id) )
    
    Permission.find_by_sql( query.to_s )
  end
end
```

Here is an advanced example:


```ruby
class User < ActiveRecord::Base
  extend Rusql
  
  def self.additional_selects
    [
        group_concat( distinct( Permission[:name] ) ).as( :permission_string_list )
    ]
  end
  
  def self.additional_joins
    user_permissions = table(:user_permissions)
    
    [
        left_outer_join( user_permissions, user_permissions[:user_id].equals( User[:id] ),
        left_outer_join( Permission,       Permission[:id].equals( user_permissions[:permission_id] )
    ]
  end
  
  def permissions
    self.permission_string_list.split(",")
  end
  
  def self.fetch(id:)
    selects = [ User[:*].as_selector ]
    selects += User.additional_selects
    
    
    query = select( selects ).
        from( User ).
        where( User[:id].equals(id) ).
        limit( 1 )
        
    User.additional_joins.each do |j|
        query = query.join( j )
    end
    
    User.find_by_sql(query.to_s).first
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sparkymat/raspy. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

