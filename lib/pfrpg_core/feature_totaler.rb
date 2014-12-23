module PfrpgTables
  class FeatureTotaler
    attr_reader :entity, :levels
    def initialize(entity)
      @entity = entity
      @levels = PfrpgCore::LevelParser.new(entity.level)
      @base_features = []
      @choose_features = []
      parse_features
    end

    def get_base_features
      @base_features
    end

    def get_choose_features
      @choose_features
    end

    def parse_features
      choices = []
      lvls = levels.parse
      lvls.keys.each do |hc|
        clazz = PfrpgClasses::Heroclass.by_name(hc)
        level = lvls[hc]
        (1..level).each do |l|
          class_features = clazz.bonuses_for_level(l)[:granted_features]
          class_features.each do |x|
            ap "Creating granted feature:"
            ap "\t#{x} (#{hc})"
            @base_features << ClassFeature.granted_feature(x, hc)
          end
          clazz.bonuses_for_level(l)[:choices].each do |choice|
            if !(choice_is_feat(choice))
              choice.npc_id = entity.id
              choices << flatten_options(choice)
            end
          end
        end
      end
      @choose_features = choices.flatten
    end

    def flatten_options(feature_choice)
      ap "feature chioce:"
      ap feature_choice.choices[:options][0]
      if feature_choice.choices[:options][0].respond_to? 'name'
        new_options = feature_choice.choices[:options].map { |x| x.name }
        ap "New options:"
        ap new_options
        feature_choice.choices[:options] = new_options
      end
      return feature_choice
    end

    def level_granted
      i = (1..levels.total).inject(0) do |sum, x|
        choices = PfrpgTables::Tables::LevelTable.for_level(x)[:choices]
        sum = sum + (choices.select { |c| choice_is_feat(c) }).size
      end
      return i
    end

    def race_granted
      race = entity.race
      i = race.bonus_choices.inject(0) do |sum, x|
        sum = sum + 1 if choice_is_feat(x)
      end
      return i
    end

    def feature_granted
      i = entity.class_features.inject(0) do |sum, x|
        choices = x.bonus_choices
        sum += (choices.select { |c| choice_is_feat(c) }).size
      end
      return i
    end

    def choice_is_feat(choice)
      choice.class.to_s['Feat'] != nil
    end

  end
end

