require 'spec_helper'

RSpec.describe 'Pwork' do

  context 'Array.peach' do

    it 'should execute items in the default number of parallel threads when thread_count not specified' do

      items = []
      items.push(1)
      items.push(2)
      items.push(3)
      items.push(4)
      items.push(5)
      items.push(6)
      items.push(7)
      items.push(8)
      items.push(9)
      items.push(10)

      results = []

      items.peach do |item|

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
          r[0][:count] += 1
        end

        sleep(0.02)

      end

      expect(results.count).to eq(5)

    end

    it 'should execute items in the specified number of parallel threads when thread_count is specified' do

      items = []
      items.push(1)
      items.push(2)
      items.push(3)
      items.push(4)
      items.push(5)
      items.push(6)
      items.push(7)
      items.push(8)
      items.push(9)
      items.push(10)

      results = []

      items.peach(10) do |item|

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end

      expect(results.count).to eq(10)

    end

    it 'should execute less items in array than thread count' do

      items = []
      items.push(1)
      items.push(2)

      results = []

      items.peach(5) do |item|

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end

      expect(results.count).to eq(2)
      expect(results[0][:count]).to eq(1)
      expect(results[1][:count]).to eq(1)

    end

  end

  context Pwork::Worker do

    it 'should execute all processes added to the worker in the default number of parallel threads when thread_count is not specified' do

      results = []

      worker = Pwork::Worker.new
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end

      worker.execute

      expect(results.count).to eq(5)

    end

    it 'should execute all processes added to the worker in the default number of parallel threads when thread_count is not specified' do

      results = []

      worker = Pwork::Worker.new(10)
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end
      worker.add do

        thread_details = Thread.current.inspect

        r = results.select { |i| i[:thread_details] == thread_details }

        if r.length == 0
          results.push({ :thread_details => thread_details, :count => 1})
        elsif
        r[0][:count] += 1
        end

        sleep(0.02)

      end

      worker.execute

      expect(results.count).to eq(10)

    end

  end

end