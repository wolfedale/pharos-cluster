# frozen_string_literal: true

require 'pharos/up_command'
require 'pharos/reset_command'
require 'pharos/version_command'
require 'pharos/kubeconfig_command'

module Pharos
  class RootCommand < Pharos::Command
    banner "pharos-cluster - Kontena Pharos cluster manager"

    subcommand ["build", "up"], "initialize/upgrade cluster", UpCommand
    subcommand "kubeconfig", "fetch admin kubeconfig file", KubeconfigCommand
    subcommand ["reset"], "reset cluster", ResetCommand
    subcommand ["version"], "show version information", VersionCommand

    def self.run
      super
    rescue StandardError => exc
      warn exc.message
      warn exc.backtrace.join("\n")
    end
  end
end
