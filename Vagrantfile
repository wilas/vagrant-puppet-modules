# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    vm_name= "pie"
    config.vm.box = "SL6"
    config.vm.host_name = "#{vm_name}.farm"
    config.vm.customize ["modifyvm", :id, "--memory", "512", "--name", "#{vm_name}"]

    # Share an additional folder to the guest VM. The first argument is
    # an identifier, the second is the path on the guest to mount the
    # folder, and the third is the path on the host to the actual folder.
    # config.vm.share_folder "v-data", "/vagrant_data", "../data"
    config.vm.share_folder "v-root", "/vagrant", "."

    config.vm.provision :puppet do |puppet|
        puppet.options = "--hiera_config hiera.yaml"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "pie.pp"
        puppet.module_path = "modules"
    end
end
