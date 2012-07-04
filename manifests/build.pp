# = Class: ganglia::common
#
# Description of ganglia::common
#
# == Parameters:
#
# $param::   Description of parameter
#
# == Actions:
# Ugly hack to install all packages needed for rpmbuilds of ganglia
#
# == Requires:
#
# == Sample Usage:
#
# == Todo:
#
# * Update documentati
#
class ganglia::build {

  package { 'libpng-devel':
    ensure => '1.2.49-1.el6_2',
  }
  package { 'libart_lgpl-devel':
    ensure => '2.3.20-5.1.el6',
  }
  package { 'python-devel':
    ensure => '2.6.6-29.el6_2.2',
  }
  package { 'libconfuse-devel':
    ensure => '2.5-4.el5',
  }
  package { 'pcre-devel':
    ensure => '7.8-3.1.el6',
  }
  package { 'autoconf':
    ensure => '2.63-5.1.el6',
  }
  package { 'automake':
    ensure => '1.11.1-1.2.el6',
  }
  package { 'libtool':
    ensure => '2.2.6-15.5.el6',
  }
  package { 'expat-devel':
    ensure => '2.0.1-11.el6_2',
  }
  package { 'rrdtool-devel':
    ensure => '1.3.8-6.el6',
  }
  package { 'freetype-devel':
    ensure => '2.3.11-6.el6_2.9',
  }
  package { 'apr-devel':
    ensure => '1.3.9-5.el6_2',
  }

}

