require './gatherer_extractor'
gatherer_extractor = GathererExtractor.new
gatherer_extractor.all_sets.each do |set|
  puts set
end
