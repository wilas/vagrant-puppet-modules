
class install_repos {

    file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6":
        ensure => file,
        owner  => "root",
        group  => "root",
        mode   => "0444",
        source => "puppet:///modules/install_repos/RPM-GPG-KEY-EPEL-6",
    }

    yumrepo { 
        "epel":
            enabled    => 1,
            descr      => 'Extra Packages for Enterprise Linux 6 - $basearch',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
            tag        => 'epel';
        "epel-debuginfo":
            enabled    => 0,
            descr      => 'Extra Packages for Enterprise Linux 6 - $basearch - Debug',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch',
            tag        => 'epel';
        "epel-source":
            enabled    => 0,
            descr      => 'Extra Packages for Enterprise Linux 6 - $basearch - Source',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch',
            tag        => 'epel';
        "epel-testing":
            enabled    => 0,
            descr      => 'Extra Packages for Enterprise Linux 6 - Testing - $basearch',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=testing-epel6&arch=$basearch',
            tag        => 'epel';
        "epel-testing-debuginfo":
            enabled    => 0,
            descr      => 'Extra Packages for Enterprise Linux 6 - Testing - $basearch - Debug',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=testing-debug-epel6&arch=$basearch',
            tag        => 'epel';
        "epel-testing-source":
            enabled    => 0,
            descr      => 'Extra Packages for Enterprise Linux 6 - Testing - $basearch - Source',
            mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=testing-source-epel6&arch=$basearch',
            tag        => 'epel';
    }

    Yumrepo <| tag == 'epel' |> { 
        failovermethod => 'priority',
        gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
        gpgcheck       => 1,
        require        => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6"],
    }

    yumrepo { 
        "puppetlabs":
            enabled        => 1,
            descr          => 'Puppet Labs Packages',
            baseurl        => 'http://yum.puppetlabs.com/el/6/products/x86_64/',
            gpgcheck       => 0;

        "puppetlabs2":
            enabled        => 1,
            descr          => 'Puppet Labs Packages Deps',
            baseurl        => 'http://yum.puppetlabs.com/el/6/dependencies/x86_64/',
            gpgcheck       => 0;
    }
}
