# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lost-socks/version"

Gem::Specification.new do |s|
  s.name        = "lost-socks"
  s.version     = Lost::Socks::VERSION
  s.authors     = ["Ryan Allen"]
  s.email       = ["ryan@yeahnah.org"]
  s.homepage    = "https://github.com/ryan-allen/lost-socks"
  s.summary     = %q{Automates verificaiton of DNS migrations.}
  s.description = %q{Lost Socks is a Ruby DSL (lol) for specifying DNS records, and verifying these records against name servers. Handy for large DNS migrations, where a record here or there are inevitably left behind, misspelled or entered incorrectly.}

  s.rubyforge_project = "lost-socks"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
