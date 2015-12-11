require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prv = nil)
    @key, @val, @next, @prev = key, val, nxt, prv
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

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
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def insert(key, val)
    last_link = tail.prev
    new_link = Link.new(key, val, tail, last_link)
    last_link.next = new_link
    tail.prev = new_link
  end

  def remove(key)
    each do |link|
      if link.key == key
        prev_link = link.prev
        next_link = link.next
        next_link.prev = prev_link
        prev_link.next = next_link
        return
      end
    end
  end

  def each(&blk)
    current_link = head.next
    until current_link == tail
      blk.call(current_link)
      current_link = current_link.next
    end
  end

  def inspect
    to_s
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
