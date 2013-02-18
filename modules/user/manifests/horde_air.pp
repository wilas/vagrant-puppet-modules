class user::horde_air {
    search User::Virtual

    $air_ssh_usr = hiera_array('air_ssh_users', undef)
    if $air_ssh_usr {
        realize( Ssh_user[$air_ssh_usr])
    }
    $air_plain_usr = hiera_array('air_plain_users', undef)
    if $air_plain_usr {
        realize( Plain_user[$air_plain_usr])
    }
}
