require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count >= num_buckets
    index = num.hash % num_buckets
    @store[index] << num
  end

  def remove(num)
    index = num.hash % num_buckets
    @store[index].delete(num)
    @count -= 1
  end

  def include?(num)
    index = num.hash % num_buckets
    @store[index].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times { @store << [] }

    @store.each do |bucket|
      bucket.each_with_index do |num, old_idx|
        new_index = num.hash % num_buckets
        @store[new_index] << num
        bucket.delete_at(old_idx)
      end
    end
  end
end
