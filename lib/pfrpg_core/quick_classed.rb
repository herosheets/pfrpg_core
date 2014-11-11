# basic class math. classes must provide latest_levels method
# with a map of heroclass name & level
module PfrpgCore
  module QuickClassed
    def get_class_level(heroclass)
      l = latest_levels[heroclass.name]
      l ||= 0
      return l
    end

    def explode_levels
      # TODO: implement me
      []
    end

    def get_total_level
      latest_levels.keys.inject(0) do |key, sum|
        sum = sum + latest_levels[key]
      end
    end

    def hit_dice
      get_total_level
    end

    def get_caster_level
      # TODO constantize somewhere better
      caster_classes = ['Bard', 'Cleric', 'Druid', 'Paladin', 'Ranger', 'Sorcerer', 'Wizard']
      caster_levels = []
      latest_levels.keys.each do |key|
        caster_levels << latest_levels[key] if caster_classes.include? key
      end
      ek_level = get_class_level(Heroclass.by_name('Eldritch Knight'))
      return (caster_levels.max + ek_level) || 0
    end
  end
end
