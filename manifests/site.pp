stage { "first": before => Stage["main"] }
stage { "last": require => Stage["main"] }

class { "install_repos": stage  => "first" }
class { "basic_package": }

class { "user::root": stage => "last"}

class { "user::virtual": }
class { "user::horde_air": }
class { "user::horde_earth": }

file { "/tmp/simple.txt":
    ensure => present,
    content => "Test me ...\n",
}

