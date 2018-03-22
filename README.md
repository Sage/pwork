# PWork


[![Travis Status](https://travis-ci.org/Sage/pwork.svg?branch=master)](https://travis-ci.org/Sage/pwork)
[![Code Climate](https://codeclimate.com/github/Sage/pwork.png)](https://codeclimate.com/github/Sage/pwork)
[![Gem Version](https://badge.fury.io/rb/pwork.png)](http://badge.fury.io/rb/pwork)

Welcome to your PWork. A gem to help with the execution of code on parallel threads.

> Parallel execution is especially useful at improving performance for long running I/O processes such as database & web service operations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pwork'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pwork

## Usage

PWork provides the following options for parallel work execution:

### Async

PWork now provides an async/await style syntax over a task queue in a similar way to nodejs & c#.

This makes writing/reading asyncronous code much easier and provides performance benefits from thread pooling behind the scenes.

Example:

    class UserModel
        include PWork::Async
        
        def save(user, permissions)
            # save the user data to the database
            async do
                user_repository.set(user)
            end
            
            # save the permissions data to the database
            async do
                permissions_repository.set(permissions)
            end
            
            # store the user data in the cache
            async(wait: false) do
                cache.set(cache_key, user)
            end
            
            # wait for all async tasks issued from this thread to complete 
            # (unless the async task specified `wait: false`)
            async :wait
        end
    end
   

The above example shows how you might use the async/wait syntax within a save method of a user model to split the blocking calls
of storing the user & permissions data in the database and updating the cache. The example above also shows how the set cache async block can be
specified as not requiring wait as the results are not needed in the sync flow.

Using the above async flow if we look at the execution time required for each of the blocking calls:

- user_repository.set # 100ms
- permissions_repository.set # 120ms
- cache.set # 40ms

In a sync flow the `save` method would take approx 260ms (100+120+40), but via async it should take no more than 120ms.


#### Environment Variables

- **PWORK_ASYNC_MODE** [String] [Optional] [Default=thread] (thread/fork/test) 
> This env var is used to specify the mode to use for async tasks.

> `test` mode processes tasks synchronously and is useful for testing.

- **PWORK_ASYNC_WAIT_SLEEP_ITERATION** [Integer] [Optional] [Default=0.01] 
> This env var is used to specify the time between wait intervals when waiting for async tasks to complete

#### Methods

#### `async do`

This is used to define a async task block that should be executed asynchronously within the task pool.

#### `async :wait`

This is used to wait for all async tasks declared from the current thread to complete.

#### `async :wait_local`

This is used to wait for all async tasks declared from the current object on the current thread to complete.

> This is useful to allow async/wait not to interfere with other async calls from within other objects)


> This is the number of threads within the async pool to use for processing async tasks           

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sage/pwork. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

This gem is available as open source under the terms of the
[MIT licence](LICENSE).

Copyright (c) 2018 Sage Group Plc. All rights reserved.

