module PfrpgCore
  class Demographics
    attr_reader :player_name, :character_name, :deity, :gender, :height, :weight
                :description
    def initialize(params)
      @player_name    = params[:player_name]
      @character_name = params[:name]
      @deity          = params[:deity]
      @gender         = params[:gender]
      @weight         = params[:weight]
      @height         = params[:height]
      @description    = params[:description]
    end

    def as_json(options={})
      {
          :player_name    => @player_name,
          :character_name => @character_name,
          :deity          => @deity,
          :gender         => @gender,
          :height         => @height,
          :weight         => @weight,
          :description    => @description
      }
    end
  end
end