# Class manage virtual users (plain_user and ssh_user)
class user::virtual {

    @user::ssh_user { 'elk':
        uid    => '505',
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==',
        attune => ['.bashrc', '.vimrc', '.vim'],
    }

    @user::ssh_user { 'yak':
        ensure => absent,
        uid    => '506',
        key    => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==',
    }

    @user::ssh_user { 'emu':
        uid         => '507',
        key         => 'AAAAB3NzaC1yc2EAAAABIwAAAQEA30Z4O2kddLLTuhZPT/WlJ29qZ5stFcGG0srP4Ga/GuRtJdXdQBRMchtoK4Jm7HWRSJhaX65QZQDitByko9Hcetq5tdL/VV+gXe2yBhN1wsTCPpefx2fOPkJdv+izCoAdEmSYUlRo9KuuJwsZxPk1eTkf89o0zkukVDwvGN0M16IeJx9x2y/V+JUSAGCMzEG8Vjjw2VQqKrhg12nLnub4vOzaZxi+QAQJEzcI/TyrB/Jtyl3nZ+gFXlJWoWhmwgSK691CqqR1FZ+QyxMIHxS47Q5/vjO7k8Z34K1L95piwtFGRKU6f64dDidzfbAvqdUQCdC6QMZ4A+eqet98XxmXjQ==',
        attune      => ['.bashrc'],
        meta_attune => 'emu',
    }

    @user::plain_user { 'puffin':
        ensure => absent,
        uid    => '508',
        attune => ['.bashrc', '.vimrc', '.vim'],
    }
}
