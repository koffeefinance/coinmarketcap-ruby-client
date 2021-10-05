module CoinMarketCap
  module Cloud
    module Connection
      private

      def headers
        {}
      end

      def connection
        @connection ||= begin
          options = {}

          options[:headers] = {}
          options[:headers]['Accept'] = 'application/json; charset=utf-8'
          options[:headers]['Content-Type'] = 'application/json; charset=utf-8'
          options[:headers]['User-Agent'] = user_agent if user_agent
          options[:headers]['X-CMC_PRO_API_KEY'] = api_key || ''

          request_options = {}
          request_options[:params_encoder] = Faraday::FlatParamsEncoder
          options[:request] = request_options if request_options.any?

          ::Faraday::Connection.new(endpoint, options) do |connection|
            connection.use ::Faraday::Request::Multipart
            connection.use ::Faraday::Request::UrlEncoded
            connection.use ::CoinMarketCap::Cloud::Response::RaiseError
            connection.use ::FaradayMiddleware::ParseJson, content_type: /\bjson$/
            connection.response(:logger, logger.instance, logger.options, &logger.proc) if logger.instance
            connection.adapter ::Faraday.default_adapter
          end
        end
      end
    end
  end
end
