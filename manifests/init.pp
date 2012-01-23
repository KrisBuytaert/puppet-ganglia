class ganglia::web {


  #      * DWOO compiled templates directory '/var/lib/ganglia/dwoo' is not writeable.
  #        Please adjust $conf['dwoo_compiled_dir'].
  #      * Views directory '/var/lib/ganglia/conf' is not readable.
  #        Please adjust $conf['views_dir'].
  #      * Directory used to store configuration information '/var/lib/ganglia/conf' is not readable.
  #        Please adjust $conf['conf_dir'].


}


class ganglia::common {

  package {
    [ ganglia-gmond, ganglia-gmond-modules-python ] :
      ensure => latest;
  }


}

class ganglia::gmond  ($deaf_yesno = 'yes',
                       $mute_yesno = 'no',
                       $host_dmax  = '0',
                       $ganglia_cluster_name,
                       $ganglia_port = 8649,
                       $enable_udp_recv_channel ='',
                       $enable_tcp_accept_channel ='',
                       $ganglia_host,
                       $ganglia_send_metadata_interval = 60) {

  #  All of these should be parameters 


  file {
    gmond-conf:
      path => "/etc/ganglia/gmond.conf",
      owner => root,
      group => root,
      backup => false,
      mode => 755,
      require => Package["ganglia-gmond"],
      content => template("ganglia/gmond.conf.erb");

    "/usr/bin/gmetric":
      require => Package["ganglia-gmond"],
      mode => 755;

    "/var/lib/ganglia-logtailer":
      mode => 755,
      ensure => directory;

  }

  service {
    gmond:
      ensure => running,
      enable => true,
      require => Package["ganglia-gmond"],
      #      subscribe => [ File[gmond-conf],Package["ganglia-gmond"] , Package["ganglia-gmond-modules-python" ]]
            subscribe => [ Package["ganglia-gmond"] , Package["ganglia-gmond-modules-python" ]]
  }

}


class ganglia::gmetad ($deaf_yesno = 'yes', 
                       $mute_yesno = 'yes', 
                       $ganglia_cluster_name, 
                       $host_dmax  = '86400',
                       $enable_udp_recv_channel ='yes',
                       $ganglia_host,
                       $enable_tcp_accept_channel ='yes',
                       $ganglia_port = 8649, 
                       $ganglia_send_metadata_interval = 60) {




  file {
    "/etc/ganglia/gmetad.conf":
      owner     => '0',
      group     => '0',
      content   => template("ganglia/gmetad.conf.erb");
  }


  # Removing gmond.conf from this class ... given that it is fully parametrized now you should be able to call 
  # gmond and gmetad on one host and have no conflicts 
  # file {
  #  gmond-conf:
  #    path => "/etc/ganglia/gmond.conf",
  #    owner => root,
  #    group => root,
  #    backup => false,
  #    mode => 755,
  #    require => Package["ganglia-gmond"],
  #    content => template("ganglia/gmond-aggregator.conf.erb");
  #}


  package {
    ganglia-gmetad:
      ensure => latest;
  }

  service {
    gmetad:
      enable => true,
      ensure => running;
  }

}
