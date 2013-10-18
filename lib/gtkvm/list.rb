require 'thor'
require 'colored'

module Gtkvm

  class List < Thor

    include Gtkvm::Helper

    desc "gtkvm", "List set of gtkvm"
    def gtkvm
      config = get_config_file
      gtkvmset_dir = config['gtkvmset_dir']
      if config['gtkvmset'].nil?
        puts "no gtkvmset in #{gtkvmset_dir}"
      else
        arrow = "=>"
        config['gtkvmset'].each do |gtkvmset|
          puts "gtkvm gtkvmset:"
          printf "%3s %s [ %s/%s ]\n", arrow, gtkvmset.green, gtkvmset_dir, gtkvmset
        end
      end
    end

    desc "moduleset", "List supported moduleset of gtkvm"
    def moduleset
    end
  end
end
