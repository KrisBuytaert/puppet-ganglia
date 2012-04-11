# = Class: ganglia::common
#
# Description of ganglia::common
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
# * Update documentation
#
class ganglia::common {

  package {[
    'ganglia-gmond',
    'ganglia-gmond-modules-python'
    ]:
      ensure => 'latest';
  }


}

