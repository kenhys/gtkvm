
module Gtkvm
  class CLI < Thor

    desc "bootstrap", "Bootstrap jhbuild."
    def bootstrap
      gtkvm_path = File.expand_path("~/.gtkvm")
      Dir.mkdir(gtkvm_path) unless File.exist?(gtkvm_path)
      Dir.chdir(gtkvm_path) do
        ["moduleset", "patches", "gtkvmset"].each do |directory|
          Dir.mkdir(directory) unless File.exist?(directory)
        end
        jhbuild_path = "#{gtkvm_path}/.jhbuild"
        if File.exist?(jhbuild_path)
          Dir.chdir(jhbuild_path) do
           `git pull`
          end
        else
          FileUtils.rm_rf(jhbuild_path, :secure=>true)
          `git clone git://git.gnome.org/jhbuild #{jhbuild_path}`
          Dir.chdir(jhbuild_path) do
            Dir.mkdir("m4")
            Dir.mkdir("build-aux")
            `./autogen.sh`
            `./configure --prefix=#{gtkvm_path}`
            `make install`
          end
        end
        File.open("gtkvm.yml", "w+") do |file|
          template = {
            'gtkvmset_dir' => "#{gtkvm_path}/gtkvmset"
          }
          file.puts(YAML.dump(template))
          puts(YAML.dump(template))
        end
      end
    end
  end
end
