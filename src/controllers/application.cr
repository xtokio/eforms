module Controller
  module Application
    extend self

    def user_logged(env)
        if env.session.int?("login") && env.session.int("login") > 0
          return true
        else
          return false
        end
    end

    class Params
      property params : ParamsJson
      def initialize(hash)
        @params = ParamsJson.new(hash)
      end
      
      class ParamsJson
        property json : Hash(String, String)
        def initialize(hash)
          @json = hash
        end      
      end
    end

  end
end