module PfrpgCore
  module Bonus
    def get_bonus(bonus)
      apply_bonuses if @bonuses == nil
      NullObject.maybe(@bonuses.get(bonus))
    end
  end
end