class Array
  def hash
    hash_token = 0
    each_with_index do |el, i|
      hash_token += el.hash ^ i.hash
    end

    hash_token
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    to_a.sort_by { |el| el.hash }.hash
  end
end

class Fixnum
end
