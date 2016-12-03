require './nn_functions'
require './mnist_manager'
require 'csv'
require 'nmatrix/nmatrix'

# プログラムの構造は、
# https://github.com/oreilly-japan/deep-learning-from-scratch/blob/master/ch03/neuralnet_mnist.py
# を参考にしている。

# 学習済みの重み(w1,w2,w3)とバイアス(b1,b2,b3)は、
# https://github.com/oreilly-japan/deep-learning-from-scratch/blob/master/ch03/sample_weight.pkl
# のデータを使用している。

class NeuralnetMnist
  include NnFunctions

  attr_accessor :w1, :w2, :w3, :b1, :b2, :b3

  def initialize
    %w(w1 w2 w3 b1 b2 b3).each do |key|
      instance_variable_set("@#{key}", N[*read_csv_as_float("params/#{key}.csv")])
    end
  end

  def read_csv_as_float(path)
    puts "loading #{path}..."
    CSV.read(path).map do |row|
      row.map { |n| n.to_f }
    end
  end

  def predict(x)
    a1 = add_bias(x.dot(w1), b1)
    z1 = sigmoid(a1)
    a2 = add_bias(z1.dot(w2), b2)
    z2 = sigmoid(a2)
    a3 = add_bias(z2.dot(w3), b3)
    softmax(a3)
  end

  def add_bias(matrix, bias)
    b = N.ones([matrix.shape[0], 1]).dot(bias)
    matrix + b
  end

  def run
    x = N[*MnistManager::read_images('t10k-images-idx3-ubyte.gz', 10000)] / 255.0 # normalization
    y = predict(x)
    t = N[*MnistManager::read_labels('t10k-labels-idx1-ubyte.gz', 10000)]
    diff = argmax(y) - t
    correct_samples = diff.select { |n| n == 0 }
    puts "accuracy =  #{correct_samples.size / diff.size.to_f}"
  end
end

NeuralnetMnist.new.run
