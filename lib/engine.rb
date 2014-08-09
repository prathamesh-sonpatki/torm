module Torm
  class Engine
    def connection
      @_connection ||= Torm::BaseConnection.new
    end
  end
end
