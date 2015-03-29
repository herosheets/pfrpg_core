module PfrpgCore
  class ClassFeature
    include PfrpgUtility::Affectable

    attr_reader :name, :description, :effects, :category,
                :special, :type, :attack_filter, :armor_filter,
                :ability_name

    def initialize(params)
      @name         = params[:name]
      @description  = params[:description]
      @effects      = params[:effects]
      @type         = params[:type]
      @category     = params[:category]
      @special      = params[:special]
      @attack_filter= params[:attack_filter]
      @armor_filter = params[:armor_filter]
      @ability_name = params[:ability_name]
    end

    def as_json(options={})
      {
          name: @name,
          description: @description,
          type: @type,
          category: @category,
          special: @special
      }
    end


    def self.granted_feature(feature_name, class_name)
      c = PfrpgClasses::Heroclass.by_name(class_name)
      f = Object::const_get("#{c.feature_type}").new()
      f.ability_name = feature_name
      f.class_name = class_name
      f
    end
  end
end