require 'open-uri'
require 'nokogiri'
require 'pry'

class GathererExtractor
  ENDPOINT = "http://gatherer.wizards.com/Pages/"

  def all_sets
    doc = Nokogiri::HTML( open("#{ENDPOINT}/Default.aspx") )
    set_nodes = doc.search('select#ctl00_ctl00_MainContent_Content_SearchControls_setAddText option')
    set_nodes.map(&:content).reject(&:empty?)
  end

  def all_cards_by_set(set)
    page = 0
    cards = []
    while true
      search_set_url = URI::encode("#{ENDPOINT}Search/Default.aspx?page=#{page}&set=[#{set.name}]")
      begin
        doc = Nokogiri::HTML( open(search_set_url) )
        cards <<  doc.search('span.cardTitle a').map do |node|
          extract_card_info(MagicCard.create(name: node.content, 
                           magic_set: set, 
                           link: ENDPOINT + node["href"][3..-1] 
                          ))
        end
        page+=1
        break if doc.at('a:contains(">")').nil?
      rescue
        sleep 1 and retry
      end
   end
   cards.flatten
  end

  def extract_card_info(card)
    doc = Nokogiri::HTML( open(card.link) )
    card
  end

end
