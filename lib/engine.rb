module Torm
  class Engine
    def connection
      @_connection ||= Torm::Adapters::PostgresAdapter.new
    end
  end
end
