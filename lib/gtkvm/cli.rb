# -*- coding: utf-8 -*-
require 'thor'
require 'gtkvm'

module Gtkvm
  class CLI < Thor

    desc "list", "Shows list of gtkvmset."
    def list
    end

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
        jhbuild_path = "#{gtkvm_path}/jhbuild"
        FileUtils.rm_rf(jhbuild_path, :secure=>true)
        `git clone git://git.gnome.org/jhbuild ~/.gtkvm/jhbuild`
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
