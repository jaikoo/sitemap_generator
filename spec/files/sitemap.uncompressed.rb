SitemapGenerator::Sitemap.default_host = "http://www.example.com"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::UncompressedFileAdapter.new
SitemapGenerator::Sitemap.sitemaps_namer = SitemapGenerator::SitemapNamer.new('sitemap', {:extension => '.xml'})
SitemapGenerator::Sitemap.sitemap_index_namer = SitemapGenerator::SitemapIndexNamer.new('sitemap_index', {:extension => '.xml'})


SitemapGenerator::Sitemap.create do
  add '/contents', :priority => 0.7, :changefreq => 'daily'

  # add all individual articles
  (1..10).each do |i|
    add "/content/#{i}"
  end

  add "/merchant_path", :host => "https://www.example.com"
end
