module PfrpgTables
  class FeatTotaler
    attr_reader :entity, :levels
    def initialize(entity)
      @entity = entity
      @levels = PfrpgCore::LevelParser.new(entity.level)
    end

    def total
      return level_granted + race_granted + feature_granted + choice_granted
    end

    def level_granted
      i = (1..levels.total).inject(0) do |sum, x|
        choices = PfrpgTables::Tables::LevelTable.for_level(x)[:choices]
        sum = sum + (choices.select { |c| choice_is_feat(c) }).size
      end
      return i
    end

    def race_granted
      i = entity.race.bonus_choices.inject(0) do |sum, x|
        sum = sum + 1 if choice_is_feat(x)
      end
      return i
    end

    def feature_granted
      i = entity.class_features.inject(0) do |sum, x|
        if x.respond_to? 'granted_choice'
          choices = [x.granted_choice].flatten
          sum += (choices.select { |c| choice_is_feat(c) }).size
        end
      end
      return i || 0
    end

    def choice_granted
      choices = []
      lvls = @levels.parse
      lvls.keys.each do |hc|
        clazz = PfrpgClasses::Heroclass.by_name(hc)
        level = lvls[hc]
        (1..level).each do |l|
          clazz.bonuses_for_level(l)[:choices].each do |choice|
            if (choice_is_feat(choice))
              choice.npc_id = entity.id
              choices << choice
            end
          end
        end
      end
      @choose_features = choices.flatten.size
    end

    def choice_is_feat(choice)
      choice.class.to_s['Feat'] != nil
    end

  end
end
