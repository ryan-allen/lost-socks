# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lost-socks/version"

Gem::Specification.new do |s|
  s.name        = "lost-socks"
  s.version     = Lost::Socks::VERSION
  s.authors     = ["Ryan Allen"]
  s.email       = ["ryan@yeahnah.org"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "lost-socks"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
