# frozen_string_literal: true

module Wikipedia
  module V1
    class Client
      include Singleton

      BASE_URL = 'https://en.wikipedia.org/w/api.php'

      def initialize; end

      def get_artist_article(name:)
        params = build_artist_article_params(name)

        uri = URI.parse(BASE_URL)
        uri.query = URI.encode_www_form(params)
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri)

        begin
          response = http.request(request)
          decode_artist_article_response(response)
        rescue Net::HTTPClientError, Net::HTTPServerError, StandardError => e
          # エラーになっても止める必要がないので空文字を返す
          Rails.logger.info("wikipedia api is not working due to some reasons: #{e.class} #{e.message}")
          ''
        end
      end

      private

      def build_artist_article_params(name)
        {
          format: 'json',
          action: 'query',
          prop: 'extracts',
          explaintext: true,
          exintro: true,
          titles: name
        }
      end

      # これはここの責務ではなさそう
      def decode_artist_article_response(response)
        decoded_response = JSON.parse(response.body)
        digged_response = decoded_response.dig("query", "pages").values.first
        digged_response["extract"]
      end
    end
  end
end
