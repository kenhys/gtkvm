module Gtkvm
  module Helper

    def get_config_path
      config_path = `pwd`.chomp + "/#{CONFIG_FILE}"
      if File.exist?(config_path)
        config_path
      else
        File.expand_path("~/#{CONFIG_DIR}/#{CONFIG_FILE}")
      end
    end

    def get_config_file
      YAML.load_file(get_config_path)
    end
  end
end
