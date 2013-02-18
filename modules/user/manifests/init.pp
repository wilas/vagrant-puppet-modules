class user {

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
                key  => $key,
                type => "ssh-rsa",
                user => $name,
            }
        }
    }
}
