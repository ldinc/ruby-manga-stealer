#!/usr/bin/ruby
require 'zip'
require 'mechanize'
url = "http://mangachan.ru/download/37563-she-is-young.html"
dest = "./data/"
links = Mechanize.new.get(url).links.select { |link| link.text.end_with? (".zip")}.reverse!
links.each do |link|
  link.click.save("#{dest}#{link.text}")
  `unzip #{dest}#{link.text} -d #{dest}#{link.text.gsub(".zip","")}`
  File.delete("#{dest}#{link.text}") if File.exist?("#{dest}#{link.text}")
end