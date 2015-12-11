require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    index = key.hash % num_buckets
    bucket = @store[index]
    bucket.include?(key)
  end

  def set(key, val)
    @count += 1
    resize! if @count >= num_buckets
    index = key.hash % num_buckets
    bucket = @store[index]

    bucket.each do |link|
      return link.val = val if link.key == key
    end

    bucket.insert(key, val)
  end

  def get(key)
    index = key.hash % num_buckets
    bucket = @store[index]
    bucket.get(key)
  end

  def delete(key)
    @count -= 1
    index = key.hash % num_buckets
    bucket = @store[index]
    bucket.remove(key)
  end

  def each(&blk)
    @store.each do |bucket|
      bucket.each do |link|
        blk.call(link.key, link.val)
      end
    end
  end

  def inspect
    to_s
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store

    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    old_store.each do |bucket|
      bucket.each do |link|
        set(link.key, link.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
