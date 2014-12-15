# == Define Resource Type: haproxy::acl
#
# This type will setup a acl block inside a listening service
#  configuration block in /etc/haproxy/haproxy.cfg on the load balancer.
#  currently it only has the ability to specify the instance name and
#  condition string. 
#
# === Requirement/Dependencies:
#
# Currently requires the puppetlabs/concat module on the Puppet Forge
#
# === Parameters
#
# [*name*]
#   The title of the resource is arbitrary and only utilized in the concat
#    fragment name.
#
# [*listening_service*]
#   The haproxy service's instance name (or, the title of the
#    haproxy::listen resource). This must match up with a declared
#    haproxy::listen resource.
#    
# [*conditional*]
#   The conditional for matching this acl.
#

define haproxy::acl (
  $listening_service = undef,
  $frontend_service  = undef,
  $conditional = ''
) {

  if $listening_service and $frontend_service {
    fail('The use of $listening_service and $frontend_service are mutually exclusive, please choose either one')
  }

  if $listening_service {
    $service = $listening_service
    $order = '20'
  }

  if $frontend_service {
    $service = $frontend_service
    $order = '15'
  }

  # Template uses $ipaddresses, $server_name, $ports, $option
  concat::fragment { "${service}_acl_${name}":
    order   => "${order}-${service}-02-${name}",
    ensure  => $ensure,
    target  => '/etc/haproxy/haproxy.cfg',
    content => template('haproxy/haproxy_acl.erb'),
  }
}
