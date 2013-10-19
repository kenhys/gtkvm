require 'thor'
require 'pp'

module Gtkvm

  class Config < Thor

    include Gtkvm::Helper

    desc "show", "Show current configuration"
    def show
      config = get_config_file
      puts "gtkvm config:"
      config.keys.each do |key|
        printf " %24s: %s\n", key.green, config[key].to_s
      end
    end
  end
end
