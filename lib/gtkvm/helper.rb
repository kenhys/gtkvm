module Gtkvm
  module Helper

    def get_config_dir
      current_dir = `pwd`.chomp
      config_path = File.join(current_dir, CONFIG_FILE)
      if File.exist?(config_path)
        current_dir
      else
        File.expand_path("~/#{CONFIG_DIR}")
      end
    end

    def get_config_path
      File.join(get_config_dir, CONFIG_FILE)
    end

    def get_config_file
      YAML.load_file(get_config_path)
    end

    def save_config_file(config)
      File.open(get_config_path, "w+") do |file|
        file.puts(YAML.dump(config))
      end
    end
  end
end
