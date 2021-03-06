build_dir = 'build_files'
Gem::Specification.new do |s|
  s.name        = 'rspec-advanced_subject'
  s.homepage    = "https://github.com/kwstannard/rspec-advanced_subject"
  s.version     = File.read("#{build_dir}/version.txt")
  s.date        = File.read("#{build_dir}/date.txt")
  s.summary     = "adding arguments to the subject"
  s.description = File.read("#{build_dir}/description.txt")
  s.authors     = `git log --format="%aN"`.split(/\n/)
  s.email       = 'kwstannard@gmail.com'
  s.files       = Dir["lib/**/*.rb"]
  s.test_files  = Dir["spec/**/*_spec.rb"]
  s.license     = 'MIT'

  s.add_dependency 'rspec', '~>3.0'
end
