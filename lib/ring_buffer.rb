require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @length = 0
    @start_idx = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    if index >= @length || index < 0
      raise "index out of bounds"
    end
    access_idx = (index + @start_idx) % @capacity
    @store[access_idx]
  end

  # O(1)
  def []=(index, val)
    if index >= @length || index < 0
      raise "index out of bounds"
    end
    access_idx = (index + @start_idx) % @capacity
    @store[access_idx] = val

  end

  # O(1)
  def pop
    if @length === 0
      raise "index out of bounds"
    end
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    @store[@length - 1] = val
    if @length > @capacity
      self.resize!
    end
  end

  # O(1)
  def shift
    if @length === 0
      raise "index out of bounds"
    end
    @store[@start_idx] = nil
    @start_idx += 1
    @length -= 1
  end

  # O(1) ammortized
  def unshift(val)
    if @capacity === @length
      self.resize!
    end

    @start_idx -= 1
    @start_idx = @start_idx % @capacity
    @length += 1
    @store[@start_idx] = val
    puts '---------------------------------------'
    print 'Stored Val: '
    puts @store[@start_idx]
    print 'Actual Val: '
    puts val
    puts '---------------------------------------'
    #Resize if length = cap
    #find new start index
    #increase length
    #assign new value at zero index of store
  end

  def first
    @store[@start_idx]
  end

  def last
    @store[@length - 1]
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    @capacity *= 2
  end
end

ring = RingBuffer.new
8.times do |i|
  ring.push(i)
end

puts '---------------------------------------'
puts '---------------------------------------'
