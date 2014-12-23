module PfrpgCore
  class Character
    include PfrpgCore::Bonus
    include Derived::CombatBonuses
    include Derived::Magic
    include Derived::Misc

    attr_accessor :levels, :class_features, :feats, :inventory, :base_skills,
                  :spells, :attributes, :saves, :alignment, :race, :saves,
                  :demographics, :character_id, :character_uuid, :avatar,
                  :racial_bonuses, :latest_levels, :bonuses, :effects, :skills,
                  :combat, :spellbooks

    def initialize(params)
      @character_uuid = params[:uuid]
      @character_id   = params[:id]
      # TODO: Refactor client to remove @character
      # computed by calling objects
      @character      = params[:character]
      @avatar         = params[:avatar]
      @demographics   = params[:demographics]
      @race           = params[:race][:race]
      @racial_bonuses = params[:race][:bonuses]
      prime_bonuses_with_racial_stats
      @attributes     = PfrpgCore::Attributes.new(params[:attributes], @bonuses)
      @levels         = params[:levels][:latest].map { |x| PfrpgCore::Level.new(x) }
      @latest_levels  = params[:levels][:latest]
      @alignment      = params[:alignment]
      @feats          = params[:feats]
      @class_features = FeatureDuplicator.filter_duplicates(params[:features])
      @inventory      = params[:inventory]
      @base_skills    = params[:base_skills]
      @spellbooks     = params[:spellbooks]
      # uncomputable until bonuses are calculated
      apply_bonuses
      @attributes.set_bonuses(@bonuses)
      @attributes.max_dex = self.get_max_dex_bonus
      @saves          = SavingThrows.new(params[:saves], @bonuses, @attributes)
      @combat         = PfrpgCore::Combat.new(self)
      @skills         = PfrpgCore::Skills.new(self)
      @spells         = PfrpgCore::SpellBooks.new(self)
    end

    def prime_bonuses_with_racial_stats
      @bonuses = PfrpgCore::Bonuses.new
      apply_effects(@racial_bonuses.map { |x| x.get_effects }.flatten)
    end

    def apply_bonuses
      apply_effects(PfrpgCore::EffectTotaler.new(self).effects)
    end

    def apply_effects(effects)
      e = PfrpgCore::EffectProcessor.new(self, effects)
      e.process_effects.each do |effect|
        effect.apply(self)
      end
    end

    def name
      @demographics.character_name
    end

    def as_json(options={})
      p = {
          :id           => @character_id,
          :uuid         => @character_uuid,
          :character    => @character,
          :demographics => @demographics,
          :attributes   => @attributes,
          :combat       => @combat,
          :saves        => @saves,
          :misc         => misc_json,
          :skills       => @skills,
          :spells       => @spells,
          :inventory    => @inventory
      }
      p[:avatar] = AvatarURL.new(@avatar) if @avatar
      p
    end

  end
end
