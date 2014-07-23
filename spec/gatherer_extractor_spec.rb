require "spec_helper"

describe GathererExtractor do
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

      @extractor = GathererExtractor.new
      expect(@extractor.all_sets).to eq(expected_sets)
    end
  end
end
