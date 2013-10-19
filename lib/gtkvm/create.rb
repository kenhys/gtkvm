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
        Dir.mkdir(vmset_path)
        if config['gtkvmset'].nil?
          config['gtkvmset'] = [vmset]
        else
          config['gtkvmset'] << vmset
        end
      end
      File.open(get_config_path, "w+") do |file|
        file.puts(YAML.dump(config))
      end
    end
  end
end
