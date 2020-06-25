require 'spec_helper'
 
describe 'nagios_config', :type => 'class' do

    host_dir = "/fakeroot/hosts"
    service_dir = "/fakeroot/services"
    owner = 'nagios_user'
    group = 'nagios_group'

    context "Should create directories with no configs, should also not purging existing configs" do
        let(:facts) {{ 
            :osfamily => 'RedHat',
            :operatingsystem => 'RedHat',
            :operatingsystemrelease => '7.0',
            :concat_basedir => '/tmp',
            :kernel => 'Linux',
            :id => 'root',
            :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        }}
        let(:params) {{
            :host_config_directory => host_dir,
      	    :service_config_directory => service_dir,
      	    :directory_owner => owner,
      	    :directory_group => group,
        }}
    
        it  { 
            should contain_file(host_dir).with(
        	    'ensure'  => 'directory',
        	    'path'    => host_dir, 
         	    'purge'   => false,
         	    'owner'   => owner,
        	    'group'   => group,
        	    'recurse' => true,
        	) 
        }

        it  { 
            should contain_file(service_dir).with(
        	    'ensure'  => 'directory',  
        	    'path'    => service_dir,
         	    'purge'   => false,
         	    'owner'   => owner,
        	    'group'   => group,
        	    'recurse' => true,
        	) 
        }
    end  

    context "Should create directories with no configs, should also purge existing configs" do
        let(:facts) {{ 
            :osfamily => 'RedHat',
            :operatingsystem => 'RedHat',
            :operatingsystemrelease => '7.0',
            :concat_basedir => '/tmp',
            :kernel => 'Linux',
            :id => 'root',
            :path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        }}
        let(:params) {{
            :host_config_directory => host_dir,
      	    :service_config_directory => service_dir,
      	    :purge_configs => true,
      	    :directory_owner => owner,
      	    :directory_group => group,
        }}
    
        it  { 
            should contain_file(host_dir).with(
        	    'ensure'  => 'directory',
        	    'path'    => host_dir, 
         	    'purge'   => true,
         	    'owner'   => owner,
        	    'group'   => group,
        	    'recurse' => true,
        	) 
        }

        it  { 
            should contain_file(service_dir).with(
        	    'ensure'  => 'directory',  
        	    'path'    => service_dir,
         	    'purge'   => true,
         	    'owner'   => owner,
        	    'group'   => group,
        	    'recurse' => true,
        	) 
        }
    end  

end