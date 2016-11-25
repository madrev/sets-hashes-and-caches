class Fixnum

  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    self.each_with_index do |el, i|
      result += (el.hash / (i + 1))
    end
    result
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |char, i|
      result += (char.ord/(i+1)).hash
    end
    result

  end
end

class Hash
  def hash
    self.to_a.sort.hash
  end
end
