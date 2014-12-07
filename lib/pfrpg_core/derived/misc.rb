module PfrpgCore
  module Derived
    module Misc

      def level_string
        str = "#{@alignment} :"
        @levels.each do |l|
          str += "#{l.name}/#{l.rank}"
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

      def misc_json
        {
            :initiative     => initiative,
            :alignment      => @alignment,
            :speed          => speed,
            :hit_points     => hit_points,
            :feats          => @feats,
            :class_features => @class_features,
            :levels         => @levels,
            :total_level    => @total_level,
            :size           => size,
            :level_string   => level_string,
            :temporary      => @character.temp_values
        }
      end
    end
  end
end