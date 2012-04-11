# = Class: ganglia::gmond
#
# Description of ganglia::gmond
#
# == Parameters:
#
# $param::   Description of parameter
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
# == Todo:
#
# * Add documentation
class ganglia::gmond (
  $ganglia_host,
  $ganglia_cluster_name,
  $deaf_yesno = 'yes',
  $mute_yesno = 'no',
  $host_dmax = '0',
  $ganglia_port = 8649,
  $enable_udp_recv_channel = '',
  $enable_tcp_accept_channel = '',
  $ganglia_send_metadata_interval = 60
) {

  file {'gmond-conf':
    path    => '/etc/ganglia/gmond.conf',
    owner   => 'root',
    group   => 'root',
    backup  => false,
    mode    => '0755',
    require => Package['ganglia-gmond'],
    content => template('ganglia/gmond.conf.erb'),
  }
  file {'/usr/bin/gmetric':
    require => Package['ganglia-gmond'],
    mode    => '0755',
  }

  file {'/var/lib/ganglia-logtailer':
    ensure  => directory,
    mode    => '0755',
  }

  service { 'gmond':
    ensure     => running,
    enable     => true,
    require    => Package['ganglia-gmond'],
    #subscribe => [
    #  File['gmond-conf'],
    #  Package['ganglia-gmond'],
    #  Package['ganglia-gmond-modules-python' ],
    #]
    subscribe  => [
      Package['ganglia-gmond'],
      Package['ganglia-gmond-modules-python' ],
    ],
  }

}

