module PfrpgCore
  class FeatFinder
    attr_reader :entity, :feats
    def initialize(entity, feats)
      @entity = entity
      @feats = feats
    end

    def find_feats
      feats = @feats
      feats = filter_feats_by_owned(feats, entity)
      feats = filter_feats_by_prereq(feats, entity)
      return feats
    end

    def filter_feats_by_owned(feats, entity)
      owned_feats = entity.feats
      feats.select do |f|
          repeat_list.include?(f.name) ||
          doesnt_include_feat(owned_feats, f)
      end
    end

    def doesnt_include_feat(feats, feat)
      !(feats.find { |x| x.name == feat.name })
    end

    def filter_feats_by_prereq(feats, entity)
      feats.select do |f|
        prereq_check(entity, f)
      end
    end

    def prereq_check(entity, feat)
      prereqs = Prerequisite.load(feat.prereq_code)
      prereqs.all? { |x| x.match(entity) }
    end

    def repeat_list
      [
        'Exotic Weapon Proficiency',
        'Martial Weapon Proficiency',
        'Weapon Focus',
        'Spell Focus',
        'Custom Feat'
      ]
    end
  end
end
