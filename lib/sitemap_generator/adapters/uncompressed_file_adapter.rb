module SitemapGenerator
  class UncompressedFileAdapter
    def write(location, raw_data)
      dir = location.directory
      if !File.exists?(dir)
        FileUtils.mkdir_p(dir)
      elsif !File.directory?(dir)
        raise SitemapError.new("#{dir} should be a directory!")
      end

      File.open(location.path, 'wb') {|f| f.write(raw_data) }
    end

  end
end 