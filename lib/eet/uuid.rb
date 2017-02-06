require 'securerandom'

module Eet
  class UUID
    def self.generate
      SecureRandom.uuid
    end
  end
end
