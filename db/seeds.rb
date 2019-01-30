require 'nokogiri'
require 'open-uri'
require 'pry'

Flag.destroy_all

flaglist = open("https://en.wikipedia.org/wiki/Gallery_of_sovereign_state_flags")
doc = Nokogiri::HTML(flaglist)
flagpages = doc.css(".gallerytext").map { |flag| flag.css("a")[0].values[0] }

flagpages.each do |flagpage|
  page = open("https://en.wikipedia.org/#{flagpage}")
  doc = Nokogiri::HTML(page)

  country = doc.css(".infobox caption").text
  if !country.nil?

    categories = ["Proportion", "Adopted", "Design"]

    vars = []
    categories.each do |cat|
      row = doc.css(".infobox tr").find { |e| e.css("th").text == cat }
      if !row.nil?
        vars << row.css("td").text
      end
    end

    Flag.create(country: country, proportion: vars[0], adoption_date: vars[1], design: vars[2])
    
  end

end
