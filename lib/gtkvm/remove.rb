module Gtkvm

  class Remove < Thor

    include Gtkvm::Helper

    desc "gtkvmset", "Remove gtkvmset"
    def gtkvmset(vmname)
      config = get_config_file
      vmset_dirs = Dir.glob("#{config['gtkvmset_dir']}/*").collect do |directory|
        File.basename(directory)
      end
      gtkvmset = config['gtkvmset']
      return if vmset_dirs.empty?

      if remove_target?(vmset_dirs, gtkvmset, vmname)
        gtkvmset.delete_if do |vmset|
          puts "Remove #{vmset}" if vmset == vmname
          vmset if vmset == vmname
        end
        config['gtkvmset'] = gtkvmset
        path = File.join(config['gtkvmset_dir'], vmname)
        FileUtils.rm_rf(path, :secure => true)
      end
      save_config_file(config)
    end

    private

    def remove_target?(dirs, vmset, vmname)
      dirs.include?(vmname) and vmset.include?(vmname)
    end
  end
end
