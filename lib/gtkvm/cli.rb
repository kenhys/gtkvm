# -*- coding: utf-8 -*-
require 'thor'
require 'gtkvm'

module Gtkvm
  class CLI < Thor

    desc "list", "Shows list of gtkvmset."
    def list(word)
    end

    desc "use GTKVMSET", "Use specific gtkvmset."
    def use(vmset)
    end
  end
end
