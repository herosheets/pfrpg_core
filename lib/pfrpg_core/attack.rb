module PfrpgCore
  class Attack
    include Filterable

    attr_accessor :weapon_name, :range, :damage, :weapon_type,
                  :base_bonus, :weapon_bonus, :weight_class, :critical_range,
                  :critical_dmg, :size, :weapon, :other_bonus, :filter_str,
                  :strength_bonus, :bab, :macros

    def initialize(args)
      @weapon_name    = args[:weapon_name]
      @range          = args[:range]
      @weight_class   = args[:weight_class]
      @damage         = args[:damage]
      @weapon_type    = args[:weapon_type]
      @critical_range = args[:critical_range]
      @critical_dmg   = args[:critical_dmg]
      @weapon_bonus   = args[:bonus] # bonus from weapon
      @strength_bonus = args[:strength_bonus]
      @bab            = args[:bab]
      @size           = args[:size]
      @filters        = args[:filters]
      @filter_str     = []
      @weapon         = args[:weapon]
      @macros         = args[:macros]
      @other_bonus    = 0 # things like weapon spec, training, etc
      apply_filters
    end

    def attack_bonus
      attacks = []
      static_bonus = NullObject.maybe(weapon_bonus) +
          NullObject.maybe(other_bonus) +
          NullObject.maybe(strength_bonus)
      base = NullObject.maybe(bab)
      attacks << (static_bonus + base)
      while(base >= 6)
        base -= 5
        attacks << (static_bonus + base)
      end
      return attacks
    end

    def as_json(options={})
      {
          :weapon_name  => @weapon_name,
          :range        => @range,
          :weight_class => @weight_class,
          :damage       => get_damage.to_s,
          :weapon_type  => @weapon_type,
          :critical_range => @critical_range,
          :critical_dmg => @critical_dmg,
          :weapon_bonus => @weapon_bonus,
          :strength_bonus   => @strength_bonus,
          :other_bonus  => @other_bonus,
          :attack_bonus => attack_bonus,
          :filters      => filter_str,
          :macros       => @macros.map { |m| m.as_json }
      }
    end

    def get_damage
      size == 'MEDIUM' ? damage.dmg_m : damage.dmg_s
    end
  end
end
