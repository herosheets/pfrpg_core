module PfrpgCore
  class Bonuses
    attr_reader :bonus_pool
    def initialize
      @bonus_pool = {}
    end

    def specials
      ['speed', 'damage_reduction', 'spell_resistance', 'class_skill']
    end

    def get(key)
      if specials.include? key
        return self.send(key)
      else
        return NullObject.maybe(@bonus_pool[key])
      end
    end

    def plus(key, value)
      begin
        v = MathHelper.is_number(value) ? value.to_i : value
        if specials.include? key
          if @bonus_pool[key]
            @bonus_pool[key] << value
          else
            @bonus_pool[key] = [value]
          end
        elsif @bonus_pool[key]
          @bonus_pool[key] += v
        else
          @bonus_pool[key] = v
        end
      rescue Exception => e
        ap @bonus_pool
        ap "Trying to add #{key}, #{value}"
      end
    end

    def speed
      [ @bonus_pool['speed'] ].flatten
    end

    def class_skill
      [ @bonus_pool['class_skill'] ].flatten
    end

    def damage_reduction
      [ @bonus_pool['damage_reduction'] ].flatten
    end

    def spell_resistance
      [ @bonus_pool['spell_resistance'] ].flatten
    end

  end
end
