# frozen_string_literal: true

require 'clamp'
require 'pharos/autoload'
require 'pharos/version'
require 'pharos/command'
require 'pharos/error'
require 'pharos/root_command'

module Pharos
  CRIO_VERSION = '1.11.2'
  KUBE_VERSION = ENV.fetch('KUBE_VERSION') { '1.11.1' }
  KUBEADM_VERSION = ENV.fetch('KUBEADM_VERSION') { KUBE_VERSION }
  ETCD_VERSION = ENV.fetch('ETCD_VERSION') { '3.2.18' }
  KUBELET_PROXY_VERSION = '0.3.7'
  COREDNS_VERSION = '1.1.3'
end
