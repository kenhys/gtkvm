module Gtkvm
  module Helper

    def get_config_dir
      config_path = `pwd`.chomp + "/#{CONFIG_FILE}"
      if File.exist?(config_path)
        config_path
      else
        File.expand_path("~/#{CONFIG_DIR}/#{CONFIG_FILE}")
      end
    end
  end
end
