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
      link = @map[key]
      update_link!(link)
      return link
    else
      value = @prc.call(key)
      @store.insert(key, value)
      @map[key] = @store.last
      eject! if count > @max
      value
    end
  end

  def inspect
    to_s
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    key = link.key
    val = link.val
    @store.remove(key)
    @store.insert(key, val)
  end

  def eject!
    first_link = @store.first
    key = first_link.key
    @store.remove(first_link)
    @map.delete(key)
  end
end
