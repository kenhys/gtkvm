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
  end
end
