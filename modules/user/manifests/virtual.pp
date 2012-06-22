# Class manage virtual users (plain_user and ssh_user)
class user::virtual {

    define user_attune( $username, $meta_attune="user" ){
        
        # Resource's name/title in puppet must be unique, so filename is hidden in resource name.
        # (e.g: users: emu and elk want define own .bashrc, resource name can't be .bashrc, but can be emu-.bashrc and elk-.bashrc)
        $filename = split($name,"${username}-")
        # notice ("Mirror, mirror, tell me true: filename is ${filename}")
        
        file { "/home/${username}/${filename}":
            source  => "puppet:///modules/user/user/${meta_attune}-${filename}",
            owner   => $username,
            group   => $username,
            recurse => true,
        }
    }

    define plain_user ( $uid, $ensure = "present", $attune = false, $meta_attune="user" ){
    
        # Absent not delete user home_dir: http://projects.puppetlabs.com/issues/9294
        user { $name:
            ensure     => $ensure,
            # password => '',
            home       => "/home/${name}",
            managehome => true,
            uid        => $uid,
        }
      
        group { $name:
            ensure  => $ensure,
            gid     => $uid,
            require => User[$name]
        }

        # Users are able to change their own passwords and puppet doesn't overwrite changes
        if $ensure == "present" {
            exec { "/vagrant/tools/setpassword.sh $name":
                path    => "/bin:/usr/bin",
                require => User[$name],
                unless  => "grep $name /etc/shadow | cut -f 2 -d : | grep -v '!'",
            }
        }

        if $ensure == "present" and $attune {
            # make $name of user_attune unique
            $attunefix = regsubst($attune,'([.]+)',"${name}-\0",'G')
            # notice ("Mirror, mirror, tell me true: attunefix is ${attunefix}")
            user_attune { $attunefix:
                username    => $name,
                meta_attune => $meta_attune,
                require     => User[$name],
            }
        }

    }

    define ssh_user ($uid, $key, $ensure = "present", $attune = false, $meta_attune="user"){

        plain_user { $name:
            uid         => $uid,
            ensure      => $ensure,
            attune      => $attune,
            meta_attune => $meta_attune,
        }
        
        if $ensure == "present" {
            ssh_authorized_key { "${name}_key":
                key    => $key,
                type   => "ssh-rsa",
                user   => $name,
            }
        }
    }

    @ssh_user { "elk": 
        uid    => "505",
        key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==",
        attune => [".bashrc", ".vimrc", ".vim"],
    }

    @ssh_user { "yak": 
        uid    => "506",
        key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==",
        ensure => absent,
    }

    @ssh_user { "emu":
        uid         => "507",
        key         => "AAAAB3NzaC1yc2EAAAABIwAAAQEA30Z4O2kddLLTuhZPT/WlJ29qZ5stFcGG0srP4Ga/GuRtJdXdQBRMchtoK4Jm7HWRSJhaX65QZQDitByko9Hcetq5tdL/VV+gXe2yBhN1wsTCPpefx2fOPkJdv+izCoAdEmSYUlRo9KuuJwsZxPk1eTkf89o0zkukVDwvGN0M16IeJx9x2y/V+JUSAGCMzEG8Vjjw2VQqKrhg12nLnub4vOzaZxi+QAQJEzcI/TyrB/Jtyl3nZ+gFXlJWoWhmwgSK691CqqR1FZ+QyxMIHxS47Q5/vjO7k8Z34K1L95piwtFGRKU6f64dDidzfbAvqdUQCdC6QMZ4A+eqet98XxmXjQ==",
        attune      => [".bashrc"],
        meta_attune => "emu",
    }

    @plain_user { "puffin":
        uid     => "508",
        attune  => [".bashrc", ".vimrc", ".vim"],
        #ensure => absent,
    }
}
