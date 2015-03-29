module PfrpgCore
  module Derived
    module Misc

      def level_string
        str = "#{@alignment.alignment} :"
        @levels.each do |l|
          str += "#{l.classname}/#{l.rank}"
          str += "*" if l.favored
        end
        str
      end

      def initiative
        initiative = 0
        initiative += @attributes.dex_mod
        initiative += get_bonus("initiative").to_i
        return initiative
      end

      def speed
        base_speed =  NullObject.maybe(@race).speed || 0
        base_speed += parse_speed_bonuses(get_bonus("speed"))
        base_speed -= armor_speed_penalty
        speeds = {}
        ['land','fly','climb','swim'].each do |type|
          speeds["#{type}_speed"] = calc_speed(type, base_speed)
        end
        speeds['speed'] = speeds['land_speed']
        return speeds
      end

      def calc_speed(speed_type, base)
        base + get_bonus("#{speed_type}_speed")
      end

      def parse_speed_bonuses(speed_bonuses)
        speed_bonus = 0
        speed_bonuses.each do |s|
          speed_bonus += s.to_i if MathHelper.is_number(s)
        end
        speed_bonus
      end

      def hit_points
        hp = @character.hit_points
        # TODO : potentially move off this method when multiple hp affect stats exist
        if (@feats.find { |x| x.name == 'Toughness' })
          hp += 3
          if (total_level > 3)
            hp += total_level - 3
          end
        end
        return hp
      end

      def size
        return @race.size if @race
        return nil
      end

      def total_level
        @levels.inject(0) {|sum, x| sum = sum + x.rank }
      end

      def hit_die
        total_level
      end

      def get_class_level(heroclass)
        l = latest_levels.find { |x| x.class_name[heroclass.name] }
        if l
          return l.class_number
        else
          return 0
        end
      end

      def explode_levels
        # TODO: implement me
        []
      end

      def hit_dice
        hit_die
      end

      def get_caster_level
        # TODO constantize somewhere better
        caster_classes = ['Bard', 'Cleric', 'Druid', 'Paladin', 'Ranger', 'Sorcerer', 'Wizard']
        caster_levels = latest_levels.select { |x| caster_classes.include? x.class_name }
        max_caster_level = caster_levels.map { |x| x.class_number }.max || 0
        ek_level = get_class_level(PfrpgClasses::Heroclass.by_name('Eldritch Knight'))
        return (max_caster_level + ek_level) || 0
      end

      def gets_familiar?
        (@class_features.find { |x| x.type == 'ArcaneBond' && x.ability_name == 'Familiar' }) != nil
      end

      def gets_companion?
        (@class_features.find { |x| x.type == 'NatureBond' && x.ability_name == 'Animal Companion' }) != nil
      end

      def misc_json
        {
            :initiative     => initiative,
            :alignment      => @alignment.alignment,
            :speed          => speed,
            :hit_points     => hit_points,
            :feats          => @feats,
            :class_features => @class_features,
            :levels         => @levels,
            :total_level    => @total_level,
            :size           => size,
            :level_string   => level_string,
            :has_familiar   => gets_familiar?,
            :has_companion  => gets_companion?,
            :temporary      => @character.temp_values
        }
      end
    end
  end
end
