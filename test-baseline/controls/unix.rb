control 'cinc-*nix' do
  impact 1.0
  title 'Validate executables outputs on linux and mac'
  desc 'Outputs should not contain trademarks on linux or mac'
  only_if { os.family != 'windows' }  
  
  describe command('echo test > /tmp/testfile') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should eq '' }
  end

  describe file('/tmp/testfile') do
    it { should be_file }
    its(:content) { should include 'test' }
  end

  describe command('inspec --version') do
    its(:exit_status) { should eq 0 }
    its(:stderr) { should include 'Redirecting to cinc-auditor...' }
  end

  describe file('/opt/cinc-auditor/bin/cinc-auditor-wrapper') do
    it { should be_file }
    its(:mode) { should cmp '0755' }
    its(:content) { should include 'Redirecting to cinc-auditor...' }
  end
  
  if os.name == 'mac_os_x'
    describe file('/usr/local/bin/inspec') do
      it { should be_symlink }
      its(:link_path) { should eq '/opt/cinc-auditor/bin/cinc-auditor-wrapper' }
    end
  elsif ENV['HAB_TEST'].nil?
    describe file('/usr/bin/inspec') do
      it { should be_symlink }
      its(:link_path) { should eq '/opt/cinc-auditor/bin/cinc-auditor-wrapper' }
    end
  end
end
