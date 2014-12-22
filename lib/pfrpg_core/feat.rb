module PfrpgCore
  class Feat
    include Affectable
    attr_reader :name, :description, :effects, :prereqs,
                :special, :type, :source

    def initialize(params)
      @name = params[:name]
      @description = params[:description]
      @effects = params[:effects] || []
      @prereqs = params[:prereqs] || []
      @special = params[:special]
      @type = params[:type]
      @source = params[:source]
    end

    def as_json(options={})
      {
          name: @name,
          description: @description,
          special: @special,
          type: @type,
          source: @source
      }
    end
  end
end