class user::horde_earth {
    search User::Virtual

    $earth_ssh_usr = hiera_array('earth_ssh_users', undef)
    if $earth_ssh_usr {
        realize( Ssh_user[$earth_ssh_usr])
    }
    $earth_plain_usr = hiera_array('earth_plain_users', undef)
    if $earth_plain_usr {
        realize( Plain_user[$earth_plain_usr])
    }
}
