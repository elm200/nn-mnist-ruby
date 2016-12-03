require "zlib"
require 'nmatrix'
require 'open-uri'

# 【RUBY】NUMO::NARRAY でニューラルネットワークでMNIST認識
# http://medfreak.info/?p=2975
# を参考にした。

class MnistManager
  class << self
    def data_dir
      "data"
    end

    def data_file_path(file_name)
      File.join(data_dir, file_name)
    end

    def read_images(file_name, n_images = nil)
      download_file(file_name)
      Zlib::GzipReader.open(data_file_path(file_name)) do |f|
        magic, n_images0 = f.read(8).unpack('N2')
        raise "This is not MNIST image file" if magic != 2051
        n_rows, n_cols = f.read(8).unpack('N2')
        n_images = n_images ? [n_images, n_images0].min : n_images0
        Array.new(n_images) do
          f.read(n_rows * n_cols).unpack('C*')
        end
      end
    end

    def read_labels(file_name, n_labels = nil)
      download_file(file_name)
      Zlib::GzipReader.open(data_file_path(file_name)) do |f|
        magic, n_labels0 = f.read(8).unpack('N2')
        raise "This is not MNIST label file" if magic != 2049
        n_labels = n_labels ? [n_labels, n_labels0].min : n_labels0
        f.read(n_labels).unpack('C*')
      end
    end

    def download_file(file_name)
      src = "http://yann.lecun.com/exdb/mnist/#{file_name}"
      dest = data_file_path(file_name)
      if File.exist?(dest)
        puts "use existing #{file_name}."
        return
      end
      puts "downloading #{file_name}..."
      open(dest, "wb") do |fout|
        open(src, "rb") do |fin|
          fout.write(fin.read)
        end
      end
    end
  end
end
