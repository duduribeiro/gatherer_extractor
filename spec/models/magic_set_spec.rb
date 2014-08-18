require 'spec_helper'
require './models/magic_set'

describe MagicSet do
  it { should have_property           :name   }
  it { should have_many :magic_cards }
end
