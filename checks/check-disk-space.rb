#!/usr/bin/env ruby
require 'trollop'

# Usage: --critical 90 --warning 70 --path '/Volumes/Macintosh\ HD'

def check_free_disk_space
  unless File.directory?(@opts[:path])
    puts "Bad path for disk space check"
    exit 3
  end
  used_percent = `df "#{@opts[:path]}" | awk '!/Filesystem/ {printf("%d", $3/$2*100)}'`
  if $?.exitstatus != 0
    puts used_percent
    exit 3
  end
  if used_percent.to_i >= @opts[:critical]
    puts "#{used_percent}| Critical: #{used_percent}% of disk space is used on #{@opts[:path]}"
    exit 2
  elsif used_percent.to_i >= @opts[:warning]
    puts "#{used_percent}|Warning: #{used_percent}% of disk space is used on #{@opts[:path]}"
    exit 1
  else
    puts "#{used_percent}"
    exit 0
  end
end

@opts = Trollop::options do
  opt :critical,    "Critical threshold %",                type: :integer, default: 90
  opt :warning,     "Warning threshold %",                 type: :integer, default: 70
  opt :path,        "Path to mounted file system",         type: :string, required: true
end

check_free_disk_space
