# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cancan}
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Bates"]
  s.date = %q{2010-04-17}
  s.description = %q{Simple authorization solution for Rails which is completely decoupled from the user's roles. All permissions are stored in a single location for convenience.}
  s.email = %q{ryan@railscasts.com}
  s.files = ["lib/cancan/ability.rb", "lib/cancan/active_record_additions.rb", "lib/cancan/controller_additions.rb", "lib/cancan/controller_resource.rb", "lib/cancan/exceptions.rb", "lib/cancan/matchers.rb", "lib/cancan/resource_authorization.rb", "lib/cancan.rb", "spec/cancan/ability_spec.rb", "spec/cancan/active_record_additions_spec.rb", "spec/cancan/controller_additions_spec.rb", "spec/cancan/controller_resource_spec.rb", "spec/cancan/exceptions_spec.rb", "spec/cancan/matchers_spec.rb", "spec/cancan/resource_authorization_spec.rb", "spec/spec_helper.rb", "CHANGELOG.rdoc", "LICENSE", "Rakefile", "README.rdoc", "init.rb"]
  s.homepage = %q{http://github.com/ryanb/cancan}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cancan}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Simple authorization solution for Rails.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
