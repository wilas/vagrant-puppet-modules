## Modular version [vagrant-puppet-flat](https://github.com/wilas/vagrant-puppet-flat)

## VM description
 
 - OS: Scientific linux 6
 - simple vm: pie.farm

## Howto

 - create SL6 box using [veewee-boxarium](https://github.com/wilas/veewee-boxarium)
 - copy ssh_keys from [ssh-gerwazy](https://github.com/wilas/ssh-gerwazy)

```
    vagrant up
    ssh root@localhost -p 2222
    ssh emu@localhost -p 2222
    ssh elk@localhost -p 2222
    vagrant destroy
```

## Good practice:
 - puppet parser validate manifest.pp
 - puppet-lint manifest.pp
 - stdlib
 - puppet-concat
 - puppet-librarian

## Bibliography

 - puppet modules: http://docs.puppetlabs.com/puppet/3/reference/modules_fundamentals.html
 - other puppet links: https://github.com/wilas/vagrant-puppet-flat
 - puppet hiera (e.g. include classes in hiera): https://github.com/wilas/vagrant-puppet-hiera


## Copyright and license

Copyright 2012, Kamil Wilas (wilas.pl)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

