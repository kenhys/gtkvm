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

    desc "remove SUBCOMMAND", "Remove tasks"
    subcommand "remove", Remove

    desc "use GTKVMSET", "Use specific gtkvmset."
    def use(vmset)
    end


  end
end
