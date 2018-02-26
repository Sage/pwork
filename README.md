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

The following environment variable can be used to specify the async task pool size:

- **PWORK_ASYNC_POOL_SIZE** [Integer] [Optional] [Default=10] 

> This is the number of threads within the async pool to use for processing async tasks           

### .peach
> This functionality is now deprecated in favour of the Async/Await model detailed above.

This method provides a parallel thread based execution of an each block iteration over an array.

**Params:**

 - **thread_count** [Integer] [Optional] [Default=5] This is the number of threads that the parallel iteration should be spread across.

**Example:**

	#array each iteration using the default thread count
    array.peach do |item|
	    ......
	end

	#array each iteration using a specified thread count
	array.peach(8) do |item|
		......
	end

### PWork::Worker

> This functionality is now deprecated in favour of the Async/Await model detailed above.

The worker object is used to attach one or more blocks of code to execute in parallel.
The number of threads to spread the parallel execution across can be specified in the workers construction.

**Params:**

 - **thread_count** [Integer] [Optional] [Default=5] This is the number of threads that the parallel execution should be spread across.

**Example:**

    #create a worker with the default number of parallel threads
    worker = Pwork::Worker.new

    #create a worker with a specific number of parallel threads
    worker = Pwork::Worker.new(threads: 8)

Then add your blocks of code to execute in parallel:

    worker.add do
	    .......
	end

	worker.add do
		.......
	end

Once all blocks of code required to be executed in parallel have been added to the worker, a call to the execute method is required to begin processing:

    worker.execute

All blocks of code will be executed in parallel across the workers threads.

> The Worker object is not asynchronous, the worker processes are executed on separate threads in parallel but the worker execute method is synchronous and will wait until all execution has completed before continuing past the **worker.execute** call line.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sage/pwork. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

