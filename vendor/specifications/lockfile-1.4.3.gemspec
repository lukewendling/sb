# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{lockfile}
  s.version = "1.4.3"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Ara T. Howard"]
  s.autorequire = %q{lockfile}
  s.cert_chain = nil
  s.date = %q{2007-03-21}
  s.email = %q{ara.t.howard@noaa.gov}
  s.executables = ["rlock", "rlock-1.4.3"]
  s.files = ["install.rb", "README", "rlock", "lib", "bin", "samples", "doc", "gemspec.rb", "lib/lockfile.rb", "lib/lockfile-1.4.3.rb", "bin/rlock", "bin/rlock-1.4.3", "samples/a.rb", "samples/nfsstore.rb", "samples/out", "samples/lock.sh", "samples/lock", "samples/lockfile", "doc/rlock.help"]
  s.homepage = %q{http://codeforpeople.com/lib/ruby/lockfile/}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{lockfile}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
