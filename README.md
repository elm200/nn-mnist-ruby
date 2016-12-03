# nn-mnist-ruby
MNIST のデータを使って Ruby で手書き数字を認識する

ゼロから作るDeep Learning ――Pythonで学ぶディープラーニングの理論と実装
https://www.oreilly.co.jp/books/9784873117584/
は deep learning の入門書として、素晴らしい本です。

Python で書かれた多数の例題を通じて、具体的に deep learning の仕組みについて学んでいくことができます。

ただ、私はふだん、Ruby でプログラムを書くことが多いので、Ruby でニューラルネットワークを実装してみたら、どうなるか興味がありました。

この「3章　ニューラルネットワーク」の例題の一部を Ruby に書き直してみたのが、本レポジトリの中身です。
https://github.com/oreilly-japan/deep-learning-from-scratch/blob/master/ch03/neuralnet_mnist.py

## 使い方

$ git clone git@github.com:elm200/nn-mnist-ruby.git
$ cd nn-mnist-ruby
$ bundle install
$ ruby neuralnet_mnist.rb

これで、MNIST の有名な手書き数字認識の例題が実行されます。

