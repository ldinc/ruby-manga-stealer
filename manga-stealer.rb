#!/usr/bin/ruby
require 'zip'
require 'mechanize'
url = 'http://mangachan.ru/download/33303-jitsu-wa-watashi-wa.html'
tmp = "19749621.zip"
dest = "./data/"
mech = Mechanize.new()
links = mech.get(url).links.select { |link| link.text.match /.*\.zip/}
ch = links.length
links.each do |link|
	link.click.save(tmp)
	Zip::File.open(tmp) do |zipfile|
		zipfile.each do |f|
			fpath = File.join("#{dest}#{ch}", f.name)
			FileUtils.mkdir_p(File.dirname(fpath))
			zipfile.extract(f, fpath) unless File.exists?(fpath)
		end
	end
	File.delete(tmp) if File.exist?(tmp)
	ch -= 1
end
