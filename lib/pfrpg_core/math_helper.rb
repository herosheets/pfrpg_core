class PfrpgCore::MathHelper
  def self.is_number(s)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

end
