# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{jeremyevans-exception_notification}
  s.version = "1.0.20090728"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rails Core Team"]
  s.date = %q{2009-07-28}
  s.email = %q{code@jeremyevans.net}
  s.extra_rdoc_files = ["README"]
  s.files = ["lib/exception_notifiable.rb", "lib/exception_notification.rb", "lib/exception_notifier.rb", "lib/exception_notifier_helper.rb", "rails/init.rb", "README", "test/exception_notifier_helper_test.rb", "test/test_helper.rb", "views/exception_notifier/_backtrace.rhtml", "views/exception_notifier/_environment.rhtml", "views/exception_notifier/_inspect_model.rhtml", "views/exception_notifier/_request.rhtml", "views/exception_notifier/_session.rhtml", "views/exception_notifier/_title.rhtml", "views/exception_notifier/exception_notification.rhtml"]
  s.homepage = %q{http://github.com/jeremyevans/exception_notification}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Gemified exception_notification rails plugin, compatible with Rails 2.3}
  s.test_files = ["test/exception_notifier_helper_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
