

class ganglia::common {

  package {
    [ ganglia-gmond, ganglia-gmond-modules-python ] :
      ensure => latest;
  }


}

class ganglia::gmond ($deaf_yesno = 'yes', 
                       $ganglia_cluster_name, 
                       $ganglia_port = 8649, 
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
                       $ganglia_cluster_name, 
                       $ganglia_host,
                       $ganglia_port = 8649, 
                       $ganglia_send_metadata_interval = 60) {



   file {
    gmond-conf:
      path => "/etc/ganglia/gmond.conf",
      owner => root,
      group => root,
      backup => false,
      mode => 755,
      require => Package["ganglia-gmond"],
      content => template("ganglia/gmond-aggregator.conf.erb");
  }


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
