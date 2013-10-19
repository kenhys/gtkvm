module Gtkvm
  class CLI < Thor
    desc "clean", "Cleaning up gtkvmset"
    def clean
      config = get_config_file
      vmset_dirs = Dir.glob("#{config['gtkvmset_dir']}/*").collect do |directory|
        File.basename(directory)
      end
      gtkvmset = config['gtkvmset']
      if vmset_dirs.empty?
        config['gtkvmset'].each do |vmset|
          puts "Cleaning up #{vmset}"
        end
        config['gtkvmset'] = []
      else
        vmset_dirs.each do |directory|
          gtkvmset.delete_if do |vmset|
            puts "Cleaning up #{vmset}" unless vmset_dirs.include?(vmset)
            not vmset_dirs.include?(vmset)
          end
        end
        config['gtkvmset'] = gtkvmset
      end
      File.open(get_config_path, "w+") do |file|
        file.puts(YAML.dump(config))
      end
    end
  end
end
