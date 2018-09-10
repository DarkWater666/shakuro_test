notification :off
interactor :simple

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard :shell do
  watch(%r{^app/assets/.*}) { `rm -rf tmp/cache` }
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(%r{(?:.+\/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end

guard :rails_best_practices do
  watch(%r{^app/(.+)\.rb$})
end
