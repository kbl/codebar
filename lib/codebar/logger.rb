require 'codebar'

module Codebar
  module Logger

    def self.debug(message)
      logger.debug(message)
    end

    def self.logger
      @logger ||= ::Logger.new(STDOUT)
    end

  end
end
