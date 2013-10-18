# -*- coding: utf-8 -*-
require 'thor'
require 'gtkvm'

module Gtkvm
  class CLI < Thor

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
    end

    desc "build GTKVMSET", "Build specific gtkvmset."
    def build(vmset)
    end

    desc "bootstrap", "Bootstrap jhbuild."
    def bootstrap
      gtkvm_path = File.expand_path("~/.gtkvm")
      Dir.mkdir(gtkvm_path) unless File.exist?(gtkvm_path)
      Dir.chdir(gtkvm_path) do
        ["moduleset", "patches", "gtkset"].each do |directory|
          Dir.mkdir(directory) unless File.exist?(directory)
        end
        jhbuild_path = "#{gtkvm_path}/.jhbuild"
        if File.exist?(jhbuild_path)
          Dir.chdir(jhbuild_path) do
           `git pull`
          end
        else
          FileUtils.rm_rf(jhbuild_path, :secure=>true)
          `git clone git://git.gnome.org/jhbuild #{jhbuild_path}`
          Dir.chdir(jhbuild_path) do
            Dir.mkdir("m4")
            Dir.mkdir("build-aux")
            `./autogen.sh`
            `./configure --prefix=#{gtkvm_path}`
            `make install`
          end
        end
      end
    end
  end
end
