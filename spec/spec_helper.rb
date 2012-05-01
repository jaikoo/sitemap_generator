require "bundler/setup"
Bundler.require
require 'rspec/autorun'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

SitemapGenerator.verbose = false

RSpec.configure do |config|
  config.mock_with :mocha
  config.include(FileMacros)
  config.include(XmlMacros)

  # Pass :focus option to +describe+ or +it+ to run that spec only
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

#
  # Helpers
  #

def rails_path(file)
  SitemapGenerator.app.root + file
end

def copy_sitemap_file_to_rails_app(extension)
  FileUtils.cp(File.join(SitemapGenerator.root, "spec/files/sitemap.#{extension}.rb"), SitemapGenerator.app.root + 'config/sitemap.rb')
end

def delete_sitemap_file_from_rails_app
  FileUtils.remove(SitemapGenerator.app.root + 'config/sitemap.rb')
rescue
  nil
end

def clean_sitemap_files_from_rails_app
  FileUtils.rm_rf(rails_path('public/'))
  FileUtils.mkdir_p(rails_path('public/'))
end

# Better would be to just invoke the environment task and use
# the interpreter.
def execute_sitemap_config
 SitemapGenerator::Interpreter.run
end

def with_max_links(num)
  original = SitemapGenerator::MAX_SITEMAP_LINKS
  SitemapGenerator::Utilities.with_warnings(nil) do
    SitemapGenerator.const_set(:MAX_SITEMAP_LINKS, num)
  end
  yield
  SitemapGenerator::Utilities.with_warnings(nil) do
    SitemapGenerator.const_set(:MAX_SITEMAP_LINKS, original)
  end
end
