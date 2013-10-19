module Gtkvm
  class CLI < Thor
    desc "create GTKVMSET", "Create recipe of gtkvmset."
    option :template, :required => true
    def create(vmset)
      config = get_config_file
      vmset_path = File.join(config['gtkvmset_dir'], vmset)
      if Dir.exist?(vmset_path)
        puts "#{vmset} is already exists"
      else
        moduleset = get_moduleset_names
        if not moduleset.include?(options[:template])
          printf "%s is not valid template", options[:template]
          return
        else
          moduleset_path = File.join("moduleset",
                                     options[:template] + ".moduleset")
          dest_dir = File.join(config['gtkvmset_dir'], vmset)
          FileUtils.mkdir_p(dest_dir)
          FileUtils.copy(moduleset_path, dest_dir)
        end
        if config['gtkvmset'].nil?
          config['gtkvmset'] = [vmset]
        else
          config['gtkvmset'] << vmset
        end
        save_config_file(config)
      end
    end
  end
end
