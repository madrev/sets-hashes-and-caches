require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets - 1
    unless self.include?(key)
      self[key] << key
      @count += 1
    end
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  private

  def [](key)
    mod = key.hash % num_buckets
    @store[mod]
  end

  def num_buckets
    @store.length
  end

  def resize!
    elements = @store.flatten
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    elements.each { |el| self.insert(el) }
  end
end
