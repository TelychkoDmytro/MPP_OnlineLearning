# namespace :parser do
desc "Here we parse online-study platforms titles and description"
task :parse => :environment do
	require 'csv'
	require 'nokogiri'
	require 'open-uri'

	url = "https://www.upwork.com/resources/top-sites-for-online-education-and-learning"
	url_local = "E:/files/New Text Document.html"
	html_content = File.read(url_local)

	doc = Nokogiri::HTML(html_content)

	div_elements = doc.xpath("//div[@style='scroll-margin-top: 150px;']")

	div_elements.each_with_index do |div, i|
			# Extract title from the current div
			title = div.at_xpath("h2").text
			
			# Extract description from the current div
			description = div.xpath("p").text
			
			# Limit Only information we need, without last paragraph
			break if i == 28
			unless Subject.exists?(name: title, description: description)
				puts "Create subject"
				s = Subject.create(name: title, description: description)
				t = Teacher.first
				s.head_teacher = t
				puts s.head_teacher.full_name
				s.save
				puts s.teachers.inspect
			end
		end
	end
# end