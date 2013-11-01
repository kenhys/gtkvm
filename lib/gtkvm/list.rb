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
        puts "gtkvm gtkvmset:"
        config['gtkvmset'].each do |gtkvmset|
          printf "%3s %s [ %s/%s ]\n", arrow, gtkvmset.green, gtkvmset_dir, gtkvmset
        end
      end
    end

    desc "moduleset", "List supported moduleset of gtkvm"
    def moduleset
      moduleset_pattern = File.join(File.dirname(File.expand_path(__FILE__)),
                                    "moduleset",
                                    "gtk+*.moduleset")
      modules = Dir.glob(moduleset_pattern).collect do |moduleset|
        File.basename(moduleset, ".moduleset")
      end
      puts "gtkvm modulesets:"
      modules.sort.each do |basename|
        printf " %s\n", basename
      end
    end
  end
end
