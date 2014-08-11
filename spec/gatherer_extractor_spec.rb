require "spec_helper"

describe GathererExtractor do
  let!(:extractor) { GathererExtractor.new  }
  describe "#all_sets" do
    it "returns all sets of gatherer" do
      stub = stub_request(:get, "#{GathererExtractor::ENDPOINT}/Default.aspx")
        .to_return(body: File.new("#{SUPPORT_PATH}/Default.aspx"), status: 200 )
      expected_sets = [
        "Eventide",
        "Fallen Empires",
        "From the Vault: Exiled",
        "Magic 2013",
        "Magic 2015 Core Set",
        "Zendikar"
      ]
      expect(extractor.all_sets).to eq(expected_sets)
    end
  end

  describe "#all_cards_by_set" do
   it "returns all cards by the set" do
     stub_request(:get, "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=0&set=%5BMagic%202015%20Core%20Set%5D")
      .to_return(body: File.new("#{SUPPORT_PATH}/SearchSetPage0.html"))
     stub_request(:get, "http://gatherer.wizards.com/Pages/Search/Default.aspx?page=1&set=%5BMagic%202015%20Core%20Set%5D")
      .to_return(body: File.new("#{SUPPORT_PATH}/SearchSetLastPage.html"))
     set = MagicSet.new
     set.name = "Magic 2015 Core Set"
     expected_cards = [
       MagicCard.new(name: "Accursed Spirit"),
       MagicCard.new(name: "Act on Impulse"),
       MagicCard.new(name: "Aegis Angel"),
       MagicCard.new(name: "Aeronaut Tinkerer"),
       MagicCard.new(name: "Venom Sliver"),
       MagicCard.new(name: "Verdant Haven"),
       MagicCard.new(name: "Vineweft"),
       MagicCard.new(name: "Void Snare")
     ]
     expect(extractor.all_cards_by_set(set)).to include(*expected_cards)
   end
  end
end
