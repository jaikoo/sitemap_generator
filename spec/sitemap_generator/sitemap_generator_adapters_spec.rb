require 'spec_helper'

describe SitemapGenerator::UncompressedFileAdapter do
	
	before :all do
  	SitemapGenerator::Sitemap.reset!
    clean_sitemap_files_from_rails_app
    copy_sitemap_file_to_rails_app(:uncompressed)
    with_max_links(10) { execute_sitemap_config }
  end

  it 'should not compress the sitemap output' do
		file_should_exist(rails_path('public/sitemap_index.xml'))	
		file_should_exist(rails_path('public/sitemap1.xml'))	
		file_should_exist(rails_path('public/sitemap2.xml'))	
  end

end