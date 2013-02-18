stage { "base": before  => Stage["main"] }
stage { "last": require => Stage["main"] }

class { "install_repos": stage => "base" }
class { "basic_package": stage => "base" }
class { "user::root": stage    => "base" }
Class["install_repos"] -> Class["basic_package"] -> Class["user::root"]

class { "user::virtual": }
class { "user::horde_air": }
class { "user::horde_earth": }

file { "/tmp/simple.txt":
    ensure  => file,
    content => "Test me ...\n",
}

