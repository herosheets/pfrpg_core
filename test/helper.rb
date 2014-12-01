class Helper

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
      [ MockFeat.new('Feat1') ]
    end
  end
end
