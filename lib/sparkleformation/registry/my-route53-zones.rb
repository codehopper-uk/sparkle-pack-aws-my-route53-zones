require 'aws-sdk-core'

zones = ::Array.new
route53 = ::Aws::Route53::Client.new

zones = route53.list_hosted_zones.hosted_zones

SfnRegistry.register(:my_hosted_zone) do |filter|
  filter << '.' unless filter.end_with?('.')
  zones.collect { |z| z.id.delete('/hostedzone/') if z.name == filter }.compact.first
end
