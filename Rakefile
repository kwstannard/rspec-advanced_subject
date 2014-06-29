# order of operation
# - build:build
# - build:push_{small,medium,large}
# - push

desc "pushes to github"
task "push" => ['build:readme'] do
  sh "hub push origin"
end

namespace :build do
  build_dir = 'build_files'
  sizes = ['small', 'medium', 'large']

  sizes.each do |size|
    desc "pushes gem to rubygems and bumps version"
    task "push_#{size}" do
      sh "gem push rspec-advanced_subject-#{read_version}.gem"
      Rake::Task["build:#{size}_version"].invoke
    end
  end

  desc "builds gem"
  task "build" => ['readme', 'date'] do
    sh "gem build rspec-advanced_subject.gemspec"
    sh "git commit --amend --no-edit"
    sh "git tag -a v#{read_version} -m 'version #{read_version}'"
  end


  desc "builds the readme file"
  task 'readme' do
    File.write("README.md", <<-README)
#rspec-advanced_subject-#{read_version}
#{File.read("#{build_dir}/description.txt")}
##example specs
```ruby
#{File.read("spec/advanced_subject_spec.rb")}
```
    README
    sh "git add README.md"
  end

  desc "builds gem date"
  task "date" do
    require 'date'
    File.write("#{build_dir}/date.txt", Date.today)
    sh "git add build_files/date.txt"
  end

  desc "bumps small version"
  task "small_version" do
    version = read_version.split(/\./) rescue ['0','0','0']
    version = [version[0], version[1], version[2].next]
    File.write("#{build_dir}/version.txt", version.join('.'))
    sh "git add build_files/version.txt"
  end

  desc "bumps medium version"
  task "medium_version" do
    version = File.read("#{build_dir}/version.txt").split(/\./) rescue ['0','0','0']
    version = [version[0], version[1].next, version[2]]
    File.write("#{build_dir}/version.txt", version.join('.'))
    sh "git add build_files/version.txt"
  end

  desc "bumps large version"
  task "large_version" do
    version = File.read("#{build_dir}/version.txt").split(/\./) rescue ['0','0','0']
    version = [ version[0].next, version[1], version[2] ]
    File.write("#{build_dir}/version.txt", version.join('.'))
    sh "git add build_files/version.txt"
  end
end

def read_version
  File.read("#{build_dir}/version.txt").strip
end
