require 'nmatrix/nmatrix'

module NnFunctions
  def sigmoid(x)
    N::ones_like(x) / ((-x).exp + 1.0)
  end

  def softmax(x)
    x2 = x - x.max(1)[0]
    x2.exp / x2.exp.sum(1)[0]
  end

  def argmax(x)
    list = x.shape[0] == 1 ? [x.to_a] : x.to_a
    res = list.map do |row|
      max = -Float::MAX
      idx = nil
      row.each_with_index do |n, i|
        if n > max
          idx = i
          max = n
        end
      end
      idx
    end
    N[*res]
  end
end
