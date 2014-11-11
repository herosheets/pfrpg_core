require 'minitest/autorun'
require 'test/helper'

class FeatFinderTest < Minitest::Test

  def test_filter_feats_by_owned
    e = PsuedoEntity.new
    feats = [ PsuedoFeat.new('Feat1') ]
    finder = FeatFinder.new(e, feats)
    assert finder.find_feats.empty?
  end


end
