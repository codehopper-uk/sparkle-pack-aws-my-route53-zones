# sparkle-pack-aws-my-iam-server-certificates
SparklePack to auto-detect Route53 Hosted Zone IDs.

h/t to [techshell](https://github.com/techshell) for this approach.

### Environment variables

The following environment variables must be set in order to use this Sparkle
Pack:

- AWS_REGION
- AWS_DEFAULT_REGION (being deprecated?)
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

### Use Cases

This SparklePack adds a registry entry that uses the AWS SDK to detect route53 
hosted zone IDs.

## Usage

Add the pack to your Gemfile and .sfn:

Gemfile:
```ruby
source 'https://rubygems.org'
gem 'sfn'
gem 'sparkle-pack-aws-aws-my-route53-zones'
```

.sfn:
```ruby
Configuration.new do
  sparkle_pack [ 'sparkle-pack-aws-my-route53-zones' ] ...
end
```

In a SparkleFormation Template/Component/Dynamic:
```ruby
allowed_parameters registry!(:my_hosted_zone, 'myzone.com')
```
The `my_hosted_zone` registry will return the ID of the route53 hosted
zone whose name matches 'myzone.com'.
