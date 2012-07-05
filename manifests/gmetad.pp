# = Class: ganglia::gmetad
#
# Description of ganglia::gmetad
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
# * Write documentation
#
class ganglia::gmetad (
  $ganglia_host,
  $ganglia_cluster_name,
  $deaf_yesno = 'yes',
  $mute_yesno = 'yes',
  $host_dmax  = '86400',
  $enable_udp_recv_channel = 'yes',
  $enable_tcp_accept_channel ='yes',
  $ganglia_port = 8649,
  $ganglia_send_metadata_interval = 60
) {

  file { '/etc/ganglia/gmetad.conf':
    owner     => 'root',
    group     => 'root',
    content   => template('ganglia/gmetad.conf.erb');
  }


  # Removing gmond.conf from this class ...
  # given that it is fully parametrized now you should be able to call
  # gmond and gmetad on one host and have no conflicts
  # file {'gmond-conf':
  #    path    => '/etc/ganglia/gmond.conf',
  #    owner   => 'root',
  #    group   => 'root',
  #    backup  => false,
  #    mode    => '0755',
  #    require => Package['ganglia-gmond'],
  #    content => template('ganglia/gmond-aggregator.conf.erb');
  #}


  package { 'ganglia-gmetad':
    ensure => 'latest';
  }

  service { 'gmetad':
    ensure    => 'running',
    enable    => true,
    subscribe => Package['ganglia-gmetad'],
  }

}
