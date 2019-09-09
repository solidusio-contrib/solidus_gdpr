# solidus_gdpr

[![CircleCI](https://circleci.com/gh/solidusio-contrib/solidus_gdpr.svg?style=svg)](https://circleci.com/gh/solidusio-contrib/solidus_gdpr)

This extension helps you respect the GDPR in your Solidus store.

## Installation

Add `solidus_gdpr` to your Gemfile:

```ruby
gem 'solidus_gdpr'
```

Bundle your dependencies and run the installation generator:

```shell
$ bundle
$ bundle exec rails g solidus_gdpr:install
```

## Usage

The GDPR grants user several rights with respect to their data. solidus_gdpr helps you in two ways:

1. it provides a centralized way to handle user requests under the GDPR (the "User Rights" section
   in the Solidus backend), and
2. it allows you to handle some of these requests automatically, with sane defaults and clean
   extension points.

Let's see how solidus_gdpr can help you in different scenarios!

### Defining data segments

solidus_gdpr allows you to automate certain GDPR-related tasks through the concept of data segments.
A data segment is any easily identifiable group of data about a user. By default, the extension
ships with two data segments:

- `profile`: represents information about a user's profile (basically what's in the `spree_users`
  table);
- `orders`: represents information about a user's orders.

Here's the simplest segment you can have:

```ruby
# app/data_segments/dummy_segment.rb
class DummySegment < SolidusGdpr::DataSegments::Base
end
```

Once the segment has been defined, you need to add it to your configuration:

```ruby
# config/initializers/solidus_gdpr.rb
SolidusGdpr.configure do |config|
  config.segments[:reviews] = 'ReviewsSegment'
end
```

As you can see, the segment has a name (which will be used in logs as well as other places such as
data exports) and nothing else. Even though perfectly valid, this segment is not very useful right
now. Let's see how to define custom GDPR-related business logic for our segments! 

#### Data export

The GDPR grants users the right to data portability, which means you need to be able to provide
users with the data you have collected about them in a commonly used electronic format.

solidus_gdpr provides a `DataExporter` service that will automatically create a ZIP export of your
user's data. This export, by default, will contain the `profile.json` and `orders.json` files,
containing information from the respective segments:

```ruby
SolidusGdpr::DataExporter.new(user).run # => 'tmp/data-exports/export-2932723756.zip'
```

If you collect additional information about your users, all you have to do is define a segment that
exposes an `#export` method. This method should return the data to be included in any data export
requests. Any object that responds to `#to_json` will do:

```ruby
# app/data_segments/reviews_segment.rb
class ReviewsSegment < SolidusGdpr::DataSegments::Base
  def export
    user.reviews.find_each.map do |review|
      {
        subject: review.subject,
        order_number: review.order.number,
        content: review.content,
        user_name: review.user_name,
        created_at: review.created_at,
      }
    end
  end
end
```

When building the data export, solidus_gdpr will use the segment's name as the name of the JSON
file, so in this case the final data export would contain three files: `profile.json`, `orders.json`
and `reviews.json`.

#### Data erasure

Another request that can be handled automatically by solidus_gdpr is the right to erasure.

The functionality here is very similar to data exports: solidus_gdpr provides a `DataEraser` service
whose job it is to erase a user's data, which is done by calling the `#erase` method on all defined
data segments and returning the segments that were processed:

```ruby
SolidusGdpr::DataEraser.new(user).run # => ['profile', 'orders']
```

The `profile` and `orders` data segments have default implementations of `#erase` which scramble
the user's data, but you can override these implementations by overriding the segments or even
define the `#erase` method for your custom segments:

```ruby
# app/data_segments/reviews_segment.rb
class ReviewsSegment < SolidusGdpr::DataSegments::Base
  def erase
    user.reviews.find_each do |review|
      review.update!(user_name: 'Anonymous User')
    end
  end
end
```

All the `#erase` calls will be wrapped in a DB transaction, so if one call fails the entire erasure
will be rolled back.

#### Data restriction

Users can also request that you retain their data, but stop any further processing. This can mean
many things, including but not limited to moving the data to cold storage, exclude the data from
any statistical analysis etc.

solidus_gdpr provides a `DataRestrictor` service that will call the `#restrict_processing` method on
all data segments. Because data processing can potentially be reverted, you also have a `#rollback`
method that will call the `#resume_processing` method on all data segments.

You can use the service like this:

```ruby
restrictor = SolidusGdpr::DataRestrictor.new(user)

restrictor.run # => ['profile', 'orders']
restrictor.rollback # => ['profile', 'orders']
```

By default, `ProfileSegment` will set the `data_processable` attribute on the `Spree::User` record
to, respectively, `false` and `true` when `#restrict_processing` and `#resume_processing` are called.
Note that you most likely won't need to implement `#restrict_processing` and `#resume_processing` on
all data segments: simply setting an attribute on the user record, and potentially notifying
third-parties, should be enough.

The extension also exposes the `Spree::User.data_processable` and `Spree::User.data_restricted`
scopes for your convenience.

### Serving requests automatically

By default, you are supposed to create GDPR requests manually from the admin panel as they come in
by email or other customer support channels. However, you can allow your users to send requests
directly to this area by creating `Spree::GdprRequest` records:

```ruby
request = Spree::GdprRequest.create!(
  intent: 'data_export', # ['data_export', 'data_erasure', 'processing_restriction']
  user: current_spree_user,
  notes: 'Any additional information here',
)
```

This could be done, for instance, in a controller attached to a self-serve form:

```ruby
class GdprRequestsController < ApplicationController
  def create
    request = Spree::GdprRequest.create!(gdpr_request_params.merge(user: current_spree_user))
    request.serve # this will run the appropriate workflow and mark the request as served

    redirect_to root_path, notice: 'Your request will be processed shortly.'
  end
end
```

Note that it is desirable to process these requests in the background, since some of them are
computationally intensive.

You might even decide to simply create the request, but then serve it manually via the admin panel
by clicking on "Serve Request".

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it
does not exist, then it will run specs, and [Rubocop](https://github.com/bbatsov/rubocop) static
code analysis. The dummy app can be regenerated by using `rake test_app`.

```shell
$ bundle
$ bundle exec rake
```

When testing your application's integration with this extension, you may use its factories. Simply
add this `require` statement to your `spec_helper`:

```ruby
require 'solidus_gdpr/factories'
```

## License

Copyright (c) 2019 [Nebulab Srls](https://nebulab.it), released under the New BSD License
