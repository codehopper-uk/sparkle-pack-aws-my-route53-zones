SparkleFormation.dynamic(:record_set) do |_name, _config = {}|

  _config[:type]        ||= 'CNAME'
  _config[:record]      ||= '*'
  _config[:attr]        ||= 'CanonicalHostedZoneName'
  _config[:description] ||= "The DNS record to add to the #{_config[:domain_name]} hosted zone"
  _config[:ttl]         ||= '60'

  parameters("#{_name}_domain_name".to_sym) do
    type 'String'
    allowed_pattern "[\\x20-\\x7E]*"
    default _config[:domain_name]
    description 'A hosted route53 DNS domain'
    constraint_description 'can only contain ASCII characters'
  end

  parameters("#{_name}_record".to_sym) do
    type 'String'
    allowed_pattern "[\\x20-\\x7E]*"
    default "#{_config[:record]}.#{_config[:domain_name]}."
    description _config[:description]
    constraint_description 'can only contain ASCII characters'
  end

  parameters("#{_name}_record_type".to_sym) do
    type 'String'
    allowed_values %w(A AAAA CNAME MX NS PTR SOA SPF SRV TXT)
    description 'The DNS record type'
    default _config[:type]
  end

  parameters("#{_name}_ttl".to_sym) do
    type 'Number'
    min_value '1'
    max_value '604800'
    description 'The maximum time to live for the DNS record'
    default _config[:ttl]
  end

  dynamic!(:route53_record_set, _name).properties do
    hosted_zone_name join!(ref!("#{_name}_domain_name".to_sym), '.')
    name ref!("#{_name}_record".to_sym)
    type ref!("#{_name}_record_type".to_sym)
    resource_records _array(
      join!(attr!(_config[:target], _config[:attr]), ('.' unless _config[:attr].to_s =~ /ip/i))
    )
    set!('TTL', ref!("#{_name}_ttl".to_sym))
  end
end