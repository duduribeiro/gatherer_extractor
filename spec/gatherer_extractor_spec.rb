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
     set = "Magic 2015 Core Set"
     expected_cards = [
       "Accursed Spirit",
       "Act on Impulse",
       "Aegis Angel",
       "Aeronaut Tinkerer",
     ]
     expect(extractor.all_cards_by_set(set)).to eq(expected_cards)
   end
  end
end
