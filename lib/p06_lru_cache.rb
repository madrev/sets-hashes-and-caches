require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
      return @store.last.val
    else
      eject! if count >= @max
      calc!(key, @prc)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key, prc)
    @store.append(key, prc.call(key))
    @map[key] = @store.last
    @store.last.val
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
    @map[link.key] = @store.last

  end

  def eject!
    key_to_eject = @store.first.key
    @store.remove(key_to_eject)
    @map.delete(key_to_eject)
  end
end
