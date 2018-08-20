# frozen_string_literal: true

require 'pharos/configuration/token_webhook'

module Pharos
  module Configuration
    class Authentication < Pharos::Configuration::Struct
      attribute :token_webhook, Pharos::Configuration::TokenWebhook
    end
  end
end
