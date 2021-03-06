# frozen_string_literal: true

# The MIT License (MIT)
#
# Copyright (c) 2019 Sebastian Katzer
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'mruby_utils/rake_tasks'

task 'mruby:strip' => 'mruby:environment' do
  MRuby.targets.each_pair do |name, spec|
    Dir["#{spec.build_dir}/bin/#{MRuby::Gem.current.name}*"].each do |bin|
      if RbConfig::CONFIG['host_os'].include? 'darwin'
        sh(*%W[strip -u -r -arch all #{bin}])
      elsif name.include? 'darwin'
        sh(*%W[#{spec.cc.command.sub!(/clang$/, 'strip')} -u -r -arch all #{bin}])
      else
        sh(*%W[strip --strip-unneeded #{bin}])
      end
    end
  end
end
