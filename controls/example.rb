# encoding: utf-8
# copyright: 2018, The Authors
nginx_params = yaml(content: inspec.profile.file('params.yml')).params

required_version = nginx_params['version']
required_modules = nginx_params['modules']


# you add controls here
control 'nginx-version' do                        # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title 'NGINX version'             # A human-readable title
  desc 'An optional description...'
  describe nginx do                 # The actual test
#    it { should be_directory }
#    it { should be_installed }
    its('version') { should cmp >= '1.10.3' }
  end
end

control 'nginx-modules' do
  impact 1.0
  title 'NGINX version'
  desc 'modules to be installed'
  describe nginx do
    its('modules') { should include 'http_ssl' }
    its('modules') { should include 'stream_ssl' }
    its('modules') { should include 'mail_ssl' }
  end
end

control 'nginx-conf' do
  impact 1.0
  title 'nginx configuration'
  desc 'the nginx config file'
  describe file('/etc/nginx/nginx.conf') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end  
