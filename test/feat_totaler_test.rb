require 'minitest/autorun'
require 'pfrpg_core'

class FeatTotalerTest < Minitest::Test

  PsuedoFeat = Struct.new(:name) do
    def prereq_code
      nil
    end
  end

  class PsuedoEntity
    attr_accessor :feats
    def initialize(feats = nil)
      @feats = feats
      @feats ||= default_feats
    end

    def default_feats
      [ PsuedoFeat.new('Feat1') ]
    end
  end

  def test_filter_feats_by_owned
    e = PsuedoEntity.new
    feats = [ PsuedoFeat.new('Feat1') ]
    finder = PfrpgCore::FeatFinder.new(e, feats)
    assert finder.find_feats.empty?
  end

end