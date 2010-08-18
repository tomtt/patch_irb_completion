lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'patch_irb_completion/version'

Gem::Specification.new do |s|
  s.name        = "patch_irb_completion"
  s.version     = PatchIRBCompletion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom ten Thij"]
  s.email       = ["ruby@tomtenthij.nl"]
  s.homepage    = "http://github.com/tomtt/patch_irb_completion"
  s.summary     = "A utility to help you check if irb completion has been patched to allow completion from the ruby debugger prompt"
  s.description = "The default irb completion code shipped with ruby produces an internal error, exiting from the running script. This script makes it easy to check if a suggested patch has been applied to your current ruby version."

  s.files        = Dir.glob("{bin,lib}/**/*")
  s.executables  = ['patch_irb_completion']
  s.require_path = 'lib'
end
