# frozen_string_literal: true

name 'ingress-nginx'
version '0.12.0'
license 'Apache License 2.0'

struct {
  attribute :configmap, Pharos::Types::Hash
  attribute :node_selector, Pharos::Types::Hash
  attribute :default_backend, Pharos::Types::Hash
}

schema {
  optional(:configmap).filled(:hash?)
  optional(:node_selector).filled(:hash?)
  optional(:default_backend).schema do
    optional(:image).filled(:str?)
  end
}

DEFAULT_BACKEND_ARM64_IMAGE = 'docker.io/kontena/pharos-default-backend-arm64:0.0.2'
DEFAULT_BACKEND_IMAGE = 'docker.io/kontena/pharos-default-backend:0.0.2'

def image_name
  return config.default_backend[:image] if config.default_backend&.dig(:image)

  if cpu_arch.name == 'arm64'
    DEFAULT_BACKEND_ARM64_IMAGE
  else
    DEFAULT_BACKEND_IMAGE
  end
end

# ~One replica per 10 workers, min 2
# @return [Integer]
def default_backend_replicas
  r = (@cluster_config.worker_hosts.size / 10.to_f).ceil

  return 2 if r < 2
  r
end

def install
  apply_stack(
    configmap: config.configmap || {},
    node_selector: config.node_selector || {},
    image: image_name,
    default_backend_replicas: default_backend_replicas
  )
end
