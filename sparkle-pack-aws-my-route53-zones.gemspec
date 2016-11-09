Gem::Specification.new do |s|
  s.name = 'sparkle-pack-aws-my-route53-zones'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.summary = 'AWS My Route53 Zones SparklePack'
  s.description = 'SparklePack to detect Route 53 Zone IDs'
  s.authors = ['Greg Swallow']
  s.email = 'gswallow@indigobio.com'
  s.homepage = 'https://github.com/gswallow/sparkle-pack-aws-my-route53-zones'
  s.files = Dir[ 'lib/sparkleformation/registry/*' ] + %w(sparkle-pack-aws-my-route53-zones.gemspec lib/sparkle-pack-aws-my-route53-zones.rb)
  s.add_runtime_dependency 'aws-sdk-core', '~> 2'
end
