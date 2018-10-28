module Voting
  class Client
    def get
      connection.get.body
    end

    private

    def connection
      @connection ||= build_connection
    end

    def build_connection
      Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def url
      "http://divulga.tse.jus.br/2018/divulgacao/oficial/296/dadosdivweb/br/br-c0001-e000296-w.js?#{Time.now.to_i}"
    end
  end
end
