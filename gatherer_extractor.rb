require 'open-uri'
require 'nokogiri'

class GathererExtractor
  ENDPOINT = "http://gatherer.wizards.com/Pages/"

  def all_sets
    doc = Nokogiri::HTML( open("#{ENDPOINT}/Default.aspx") )
    set_nodes = doc.search('select#ctl00_ctl00_MainContent_Content_SearchControls_setAddText option')
    set_nodes.map(&:content).reject(&:empty?)
  end

  def all_cards_by_set(set)
    search_set_url = URI::encode("#{ENDPOINT}Search/Default.aspx?page=0&set=[#{set}]")
    doc = Nokogiri::HTML( open(search_set_url) )
    card_nodes = doc.search('span.cardTitle a')
    card_nodes.map(&:content)
  end
end
