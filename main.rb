require './gatherer_extractor'
require './database'
require './models/magic_set.rb'
require './models/magic_card.rb'
require 'pry'

gatherer_extractor = GathererExtractor.new
Database.new.setup
start = Time.new
pool = []
gatherer_extractor.all_sets.each do |set|
  set = MagicSet.first_or_create(name: set)
  pool << Thread.new {
    gatherer_extractor.all_cards_by_set(set).map{|card| puts card}
  }
end
pool.each(&:join)
puts "Time: #{Time.new - start}s"
