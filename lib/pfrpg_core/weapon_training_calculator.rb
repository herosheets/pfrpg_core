module PfrpgCore
  class WeaponTrainingCalculator
    attr_reader :character, :trained_types
    def initialize(character)
      @character = character
      @trained_types = gen_trained_types
    end

    def gen_trained_types
      types = []
      trains = character.class_features.select { |x| x.type['WeaponTraining'] }
      trains.sort! { |x,y| x.created < y.created }
      trains.each do |train|
        types << train.ability_name
      end
      types
    end

    def feature_trained?(weapon, feature)
      PfrpgTables::Tables::Weapons.weapon_training_members(feature.ability_name).include? weapon.get_base_name
    end

    def trained_value(weapon, feature)
      return 0 unless feature_trained?(weapon, feature)
      bonus = trained_types.size
      weapon_name = weapon.get_base_name
      trained_types.each do |t|
        if PfrpgTables::Tables::Weapons.weapon_training_members(t).include? weapon_name
          return bonus
        end
        bonus -= 1
      end
      return 0
    end
  end
end