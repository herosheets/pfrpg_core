module PfrpgCore
  class ClassFeature
    include Affectable

    attr_reader :name, :description, :effects, :category,
                :special, :type
    def initialize(params)
      @name         = params[:name]
      @description  = params[:description]
      @effects      = params[:effects]
      @type         = params[:type]
      @category     = params[:category]
      @special      = params[:special]
    end

    def as_json(options={})
      {
          name: @name,
          description: @description,
          type: @type,
          category: @category,
          name: @name
      }
    end
  end
end