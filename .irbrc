if defined?(::Bundler)
  global_gemset = ENV['GEM_PATH'].split(':').grep(/ruby.*@global/).first
  if global_gemset
    all_global_gem_paths = Dir.glob("#{global_gemset}/gems/*")
    all_global_gem_paths.each do |p|
      gem_path = "#{p}/lib"
      $LOAD_PATH << gem_path
    end
  end
end

require 'irb/completion'
require 'irb/ext/save-history'
require 'pp'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

gems = %w[rubygems awesome_print what_methods net-http-spy map_by_method]
if RUBY_VERSION.to_f < 2.0
  gems << 'wirble'
  gems << 'hirb'
end
gems.each do |gem|
  begin
    require gem
  rescue LoadError
  end
end

# load wirble
if RUBY_VERSION.to_f < 2.0
  begin
    Wirble.init
    Wirble.colorize
    Hirb.enable
    extend Hirb::Console
  rescue LoadError
  end
end


require 'benchmark'
def benchmark(n, &block)
  Benchmark.bm do |x|
    x.report do
      n.times { block.call }
    end
  end
end

puts " > #{gems.join(', ')} <"

