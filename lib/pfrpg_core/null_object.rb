module PfrpgCore
  class NullObject < Numeric
    def to_a; []; end
    def to_s; ""; end
    def to_str; ""; end
    def to_f; 0.0; end
    def to_i; 0; end

    def empty?
      true
    end

    def as_json(options={})
      ""
    end

    def method_missing(*args, &block)
      self
    end

    def self.maybe(value)
      case value
        when nil then NullObject.new
        else value
      end
    end

    def +(other)
      case other
        when String
          to_s + other
        when Fixnum
          to_i + other
        when Float
          to_f + other
      end
    end
  end
end