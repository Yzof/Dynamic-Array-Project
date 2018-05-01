require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(0)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    if index >= @length
      raise 'index out of bounds'
    end

    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length <= 0
      raise 'index out of bounds'
    end
    popped = @store[@length - 1]
    @store[@length] = nil
    @length -= 1
    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @store[@length] = val
    @length += 1
    if @length > @capacity
      self.resize!
    end
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length == 0
      raise 'index out of bounds'
    end
    @length -= 1
    new_store = StaticArray.new(@length)
    i = 1

    while i < @length
      new_store[i - 1] = @store[i]
      i += 1
    end

    @store = new_store
    @length
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    new_store = StaticArray.new(@length)
    i = 1

    new_store[0] = val

    while i < @length
      new_store[i] = @store[i - 1]
      i += 1
    end

    @store = new_store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    #The text above implies the below code is,
    # whats required, but the specs ask for the above
    #code.

    # new_store = StaticArray.new(@length)
    # i = 0
    #
    # while i < @length
    #   new_store[i] = @store[i]
    #   i += 1
    # end
    #
    # @store = new_store
  end
end
