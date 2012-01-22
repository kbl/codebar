require 'codebar'

module Codebar
  module Logger

    extend self

    def debug(message)
      logger.debug(message)
    end

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end

  end
end
