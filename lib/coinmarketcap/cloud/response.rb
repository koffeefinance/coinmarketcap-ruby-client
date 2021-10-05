module CoinMarketCap
  module Cloud
    module Response
      class RaiseError < ::Faraday::Response::RaiseError
        def on_complete(env)
          case env[:status]
          when 404
            raise Faraday::ResourceNotFound, response_values(env)
          when 401, 403
            raise CoinMarketCap::Errors::PermissionDeniedError, response_values(env)
          when ClientErrorStatuses
            raise CoinMarketCap::Errors::ClientError, response_values(env)
          else
            super
          end
        end
      end
    end
  end
end
