module Eet
  class Validator
    VALIDATORS = {
      dic_popr: /^CZ[0-9]{8,10}$/,
      id_provoz: /^[1-9][0-9]{0,5}$/,
      id_pokl: /^[0-9a-zA-Z\.,:;\/#_ -]{1,20}$/,
      porad_cis: /^[0-9a-zA-Z\.,:;\/#_ -]{1,25}$/,
      castka: /^-?[\d.]+$/,
      datum: /^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(Z|[+\-]\d\d:\d\d)$/
    }

    class << self

      VALIDATORS.keys do |key|
        define_method "validate_#{key}" do |val|
          general_validator(key, val)
        end
      end

      def validate_castka(val)
        value = val.to_f
        general_validator(VALIDATORS[:castka], val) && value.abs < 100_000_000
      end

      private

      def general_validator(validator, value)
        !!(value.to_s =~ validator)
      end
    end
  end
end
