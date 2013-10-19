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
          dest_path = "#{dest_dir}/#{vmset}.moduleset"
          FileUtils.copy(moduleset_path, dest_path)
        end
        if config['gtkvmset'].nil?
          config['gtkvmset'] = [vmset]
        else
          config['gtkvmset'] << vmset
        end
        File.open("#{vmset_path}/#{vmset}.jhbuildrc", "w+") do |file|
          content = get_jhbuildrc_content(vmset, options[:template])
          file.puts(content)
        end
        save_config_file(config)
      end
    end

    private

    def get_jhbuildrc_content(vmname, template)
      gtkvmset_dir = get_gtkvmset_dir(vmname)
      tarball_dir = get_tarball_dir
      flavour_content = get_file_contents("jhbuildrc/flavour.py")
      templaterc = get_file_contents("jhbuildrc/#{template}")
      jhbuildrc = [
        flavour_content,
        "moduleset = '#{gtkvmset_dir}/#{vmname}.moduleset'",
        "jhmodules = ['gtk+']",
        "checkoutroot = '#{gtkvmset_dir}/build/' + flavour_ext + '/'",
        "tarballdir = '#{tarball_dir}'",
        "prefix = '#{gtkvmset_dir}/' + flavour_ext + '/'",
        "os.environ['prefix'] = prefix",
        templaterc
      ]
      jhbuildrc.join("\n")
    end
  end
end
