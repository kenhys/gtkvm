module Gtkvm
  class CLI < Thor

    desc "build GTKVMSET", "Build specific gtkvmset."
    def build(vmset)
      config = get_config_file
      gtkvmset_dir = get_gtkvmset_dir(vmset)
      tarball_dir = config['tarball_dir']
      jhbuildrc_path = File.join(gtkvmset_dir, "jhbuildrc")
      jhbuild_path = get_jhbuild_path
      if File.exist?(jhbuildrc_path)
        command="#{jhbuild_path} -f #{jhbuildrc_path}"
        `#{command}`
      else
        message = "jhbuildrc doesn't exist for #{vmset.green}"
        printf "%s: %s\n", "Error".red, message
      end
    end
  end
end
