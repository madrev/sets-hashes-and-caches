class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable
  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    i += @count if i < 0
    return nil unless (0...@count).cover?(i)
    @store[i]
  end

  def []=(i, val)
    resize! until @store.length > i
    i += @count if i < 0
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      return true if el == val
    end
    false
  end

  def push(val)
    resize! if @count == @store.length
    @store[@count] = val
    @count += 1
    self
  end

  def unshift(val)
    resize! if @count == @store.length
    i = @count - 1
    while i >= 0
      @store[i + 1] = @store[i]
      i -= 1
    end
    @store[0] = val
    @count += 1
    self
  end

  def pop
    return nil if @count == 0
    el = @store[@count - 1]
    @store[@count - 1] = nil
    @count -= 1
    el
  end

  def shift
    el = @store[0]
    @store[0] = nil
    i = 1
    while i < @count
      @store[i-1] = @store[i]
      i += 1
    end
    @count -= 1
    el
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each
    i = 0
    while i < @count
      yield(@store[i])
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    self.each_with_index do |el, i|
      return false if other[i] != el
    end
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@store.length * 2)
    i = 0
    self.each do |el|
      new_store[i] = el
      i += 1
    end
    @store = new_store
  end
end
