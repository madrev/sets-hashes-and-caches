require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = self.next
    @next.prev = self.prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    self.each do |link|
      return true if link.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key,val)
    last = @tail.prev
    last.next = new_link
    new_link.prev = last
    new_link.next = @tail
    @tail.prev = new_link
  end

  def update(key, val)
    self.each do |link|
      link.val  = val if link.key == key
    end
    nil
  end

  def remove(key)
    #byebug
    self.each do |link|
      link.remove if link.key == key
    end
    nil
  end

  def each
    current_link = @head.next
    until current_link == @tail
      yield current_link
      current_link = current_link.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
