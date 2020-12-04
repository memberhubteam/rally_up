# RallyUp Ruby Library

The RallyUp ruby library provides a ruby wrapping around the [RallyUp API](https://api.rallyup.com/) and the [RallyUp Partner API](https://partnerapi.rallyup.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rally_up'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rally_up

## API Usage

```
require 'rally_up'
```

## Partner API Usage

```
require 'rally_up'

# Setup your Partner API Variable
RallyUp::Partner.domain = 'my.partnerdomain.com'
RallyUp::Partner.login  = 'login'
RallyUp::Partner.secret = 's3cr3t'

# Authorization
RallyUp::Partner::Token.retrieve
RallyUp::Partner::Token.retrieve(set: false) # to not change RallyUp::Partner.token value

# Once authorized, use the Partner API...

# Campaigns
RallyUp::Partner::Campaign.list(organization_id: 123)
RallyUp::Partner::Campaign.retrieve(12345)

# Campaign Items
RallyUp::Partner::CampaignItem.list(123)

# Organizations
RallyUp::Partner::Organization.list
RallyUp::Partner::Organization.list(start_date: '2020-01-01', end_date: '2020-01-30')
RallyUp::Partner::Organization.retrieve(12345)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rally_up.
