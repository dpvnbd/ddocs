ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
unless ( (('2.5.0'..'2.5.1').include? RUBY_VERSION) && defined?(Debugger) )
    require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end