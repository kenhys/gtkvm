require 'thor'

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
        config['gtkvmset'].each do |gtkvmset|
          puts "#{gtkvmset} [#{gtkvmset_dir}/#{gtkvmset}]"
        end
      end
    end

    desc "moduleset", "List supported moduleset of gtkvm"
    def moduleset
    end
  end
end
