# = Class: ganglia::web
#
# Description of ganglia::web
#
# == Actions:
#
# == Requires:
#
# == Sample Usage:
#
# == Todo:
#
# * Update documentation
#
class ganglia::web {


  # DWOO compiled templates directory '/var/lib/ganglia/dwoo' is not writeable.
  # Please adjust $conf['dwoo_compiled_dir'].
  # Views directory '/var/lib/ganglia/conf' is not readable.
  # Please adjust $conf['views_dir'].
  # Directory used to store configuration information
  # '/var/lib/ganglia/conf' is not readable.
  # Please adjust $conf['conf_dir'].

  package {'gweb':
    ensure => present;
  }

  file { '/var/lib/ganglia/dwoo/':
    ensure    => 'directory',
    owner     => 'apache',
    group     => 'apache',
    mode      => '0755',
  }

  file { '/var/lib/ganglia/conf':
    ensure    => 'directory',
    owner     => 'apache',
    group     => 'apache',
    mode      => '0755',
  }
  file { '/var/lib/ganglia/dwoo/cache':
    ensure    => 'directory',
    owner     => 'apache',
    group     => 'apache',
    mode      => '0755',
  }
  file { '/var/lib/ganglia/dwoo/compiled':
    ensure    => 'directory',
    owner     => 'apache',
    group     => 'apache',
    mode      => '0755',
  }

  service {'httpd':
    ensure => running;
  }

}

