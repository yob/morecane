#!/usr/bin/env rake
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  warn "rspec not available, spec task not provided"
end

begin
  require 'cane/rake_task'
  require 'morecane'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 11
    #cane.add_threshold 'coverage/covered_percent', :>=, 100
    cane.use Morecane::EncodingCheck, encoding_glob: "{lib,spec}/**/*.rb"
  end

  task :default => :quality
rescue LoadError
  warn "cane not available, quality task not provided."
end
