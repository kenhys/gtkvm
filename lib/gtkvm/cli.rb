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
      config_dir = get_config_dir
      p config_dir
    end

    desc "build GTKVMSET", "Build specific gtkvmset."
    def build(vmset)
    end

  end
end
