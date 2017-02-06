module Eet
  class Receipt
    STRINGS = %i{porad_cis dat_trzby}.freeze

    # we have to validate these
    NUMBERS = %i{celk_trzba zakl_nepodl_dph zakl_dan1 dan1 zakl_dan2 dan2 zakl_dan3 dan3
                 cest_sluz pouzit_zboz1 pouzit_zboz2 pouzit_zboz3 urceno_cerp_zuct cerp_zuct}.freeze

    # whole dataset
    ATTRIBUTES = STRINGS + NUMBERS

    attr_reader :data

    def initialize(options = {})
      @data = {}
      ATTRIBUTES.each { |v| @data[v] = options.fetch(v) { nil } }
    end

    ATTRIBUTES.each do |key|
      define_method key do
        @data.fetch(key) { nil }
      end

      define_method "#{key}=" do |val|
        @data[key] = val
      end
    end

    def valid?
      NUMBERS.each do |num|
        value = self.send(num)
        next unless value
        return false if Validator.validate_castka(value)
      end
      Validator.validate_porad_cis(porad_cis) && Validator.validate_datum(dat_trzby)
    end
  end
end
