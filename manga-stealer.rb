#!/usr/bin/ruby
require 'mechanize'
url = "http://mangachan.ru/download/37563-she-is-young.html"
dest = "./data/"
links = Mechanize.new.get(url).links.select { |link| link.text.end_with? (".zip")}.reverse!
links.each_with_index do |link,chapter|
  link.click.save("#{dest}#{link.text}")
  `unzip #{dest}#{link.text} -d #{dest}#{chapter+1} && rm #{dest}#{link.text}`
end