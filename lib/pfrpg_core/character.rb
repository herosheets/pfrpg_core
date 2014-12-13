module PfrpgCore
  class Character
    include PfrpgCore::Bonus
    include Derived::CombatBonuses
    include Derived::Magic
    include Derived::Misc

    attr_accessor :levels, :class_features, :feats, :inventory, :base_skills,
                  :spells, :attributes, :saves, :alignment, :race, :saves,
                  :demographics, :character_id, :character_uuid, :avatar

    def initialize(params)
      generate_effects
      @character_uuid = params[:uuid]
      @character_id   = params[:id]
      # TODO: Refactor client to remove @character
      # computed by calling objects
      @character      = params[:character]
      @avatar         = params[:avatar]
      @demographics   = params[:demographics]
      @race           = params[:race]
      @levels         = params[:levels]
      @alignment      = params[:alignment]
      @feats          = params[:feats]
      @class_features = params[:class_features]
      @inventory      = params[:inventory]
      @spells         = params[:spells]
      @combat         = params[:combat]
      @base_skills    = params[:base_skills]
      # uncomputable until bonuses are calculated
      @attributes     = PfrpgCore::Attributes.new(params[:attributes], @bonuses)
      @saves          = SavingThrows.new(params[:saves], @bonuses, @attributes)
    end

    def generate_effects
      @bonuses = PfrpgCore::Bonuses.new
      @effects = PfrpgCore::EffectTotaler.new(self).effects
      e = PfrpgCore::EffectProcessor.new(self, @effects)
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
          :skills       => Skills.new(self), # crazy
          :spells       => @spells,
          :inventory    => @inventory
      }
      p[:avatar] = AvatarURL.new(@avatar) if @avatar
      p
    end


  end
end