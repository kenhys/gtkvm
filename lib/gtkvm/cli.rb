# -*- coding: utf-8 -*-
require 'thor'
require 'gtkvm'
require 'yaml'

module Gtkvm
  class CLI < Thor

    include Gtkvm::Helper

    desc "list SUBCOMMAND", "List gtkvmset"
    subcommand "list", List

    desc "config SUBCOMMAND", "Configuration tasks"
    subcommand "config", Config

    desc "moduleset SUBCOMMAND", "Moduleset tasks"
    subcommand "moduleset", Moduleset

    desc "use GTKVMSET", "Use specific gtkvmset."
    def use(vmset)
    end

    desc "create GTKVMSET", "Create recipe of gtkvmset."
    option :template
    def create(vmset)
      config = get_config_file
      vmset_path = File.join(config['gtkvmset_dir'], vmset)
      if Dir.exist?(vmset_path)
        puts "#{vmset} is already exists"
      else
        Dir.mkdir(vmset_path)
        if config['gtkvmset'].nil?
          config['gtkvmset'] = [vmset]
        else
          config['gtkvmset'] << vmset
        end
      end
      File.open(get_config_path, "w+") do |file|
        file.puts(YAML.dump(config))
      end
    end

  end
end
