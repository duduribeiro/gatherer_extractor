require 'open-uri'
require 'nokogiri'
class GathererExtractor
  ENDPOINT = "http://gatherer.wizards.com/Pages/"

  def all_sets
    doc = Nokogiri::HTML( open("#{ENDPOINT}/Default.aspx") )
    set_nodes = doc.search('select#ctl00_ctl00_MainContent_Content_SearchControls_setAddText option')
    set_nodes.map(&:content).reject(&:empty?)
  end
end
