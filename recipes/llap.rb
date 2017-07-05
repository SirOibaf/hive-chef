# Install Slider
group node.slider.group do
  action :create
  not_if "getent group #{node.slider.group}"
end

user node.slider.user do
  home "/home/#{node.slider.user}"
  action :create
  shell "/bin/bash"
  manage_home true
  not_if "getent passwd #{node.slider.user}"
end

group node.slider.group do
  action :modify
  members ["#{node.slider.user}"]
  append true
end

package_url = "#{node.slider.url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "/tmp/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node.slider.user}"
  mode "0644"
  action :create_if_missing
end

# Extract Slider
slider_downloaded = "#{node.slider.home}/.slider_extracted_#{node.slider.version}"

bash 'extract-slider' do
        user "root"
        group node.slider.group
        code <<-EOH
                set -e
                mkdir /tmp/apache-slider-#{node.slider.version}
                tar zxf #{cached_package_filename} -C /tmp
                mv /tmp/slider-#{node.slider.version}-incubating #{node.slider.dir}
                # remove old symbolic link, if any
                rm -f #{node.slider.base_dir}
                ln -s #{node.slider.home} #{node.slider.base_dir}
                chown -R #{node.slider.user}:#{node.slider.group} #{node.slider.home}
                chown -R #{node.slider.user}:#{node.slider.group} #{node.slider.base_dir}
                touch #{slider_downloaded}
                chown -R #{node.slider.user}:#{node.slider.group} #{slider_downloaded}
        EOH
     not_if { ::File.exists?( "#{slider_downloaded}" ) }
end

# Add Slider to PATH
magic_shell_environment 'PATH' do
  value "$PATH:#{node.slider.base_dir}/bin"
end

# Launch LLAP Cluster
bash 'launch-llap' do
        user node.hive2.user
        group node.hive2.group
        code <<-EOH
                set -e
                #{node.hive2.base_dir}/bin/hive --service llap --name #{node.llap.cluster_name} --output #{node.hive2.base_dir}/bin/llap -z
        EOH
        not_if { ::File.exists?( "#{node.hive2.base_dir}/bin/llap" ) || node.hive2.execution_mode == "container" }
end
