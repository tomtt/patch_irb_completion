require 'find'

module PatchIRBCompletion
  class Suggest
    def self.find_ruby_lib_path
      ruby_bin_path = `which ruby`
      ruby_path = File.expand_path(File.join(ruby_bin_path, "..", "..", "lib"))
      unless File.exist?(ruby_path)
        ruby_path = `ruby -e "puts $:[0]"`
      end
    end

    def self.find_completion_source_in_dir(dir)
      Find.find(dir) do |filename|
        # puts filename
        next unless File.basename(filename) == "completion.rb"
        return filename
      end
      nil
    end

    def self.find_completion_source_in_current_ruby_version
      $:.each do |lib_dir|
        completion_file = find_completion_source_in_dir(lib_dir)
        next unless completion_file
        return completion_file
      end
    end

    def self.check_if_completion_source_file_has_offending_code(filename)
      unpatched_code = "IRB.conf[:MAIN_CONTEXT].workspace"
      File.read(filename).include?(unpatched_code)
    end

    def self.call
      filename = find_completion_source_in_current_ruby_version
      if check_if_completion_source_file_has_offending_code(filename)
        puts <<EOT
The file \"#{filename}\" has not been patched... I would suggest you replace:
    bind = IRB.conf[:MAIN_CONTEXT].workspace.binding (line 38)
with:
    context = IRB.conf[:MAIN_CONTEXT]
    bind = context ? context.workspace.binding : binding
EOT
      else
        puts "The file \"#{filename}\" is patched."
      end
    end
  end
end
