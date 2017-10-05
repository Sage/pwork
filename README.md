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

### #.peach
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

