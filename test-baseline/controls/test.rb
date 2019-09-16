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
  its(:stdout) { should include 'Redirecting to cinc-auditor...' }
end

describe file('/opt/cinc-auditor/bin/cinc-auditor-wrapper') do
  it { should be_file }
  its(:mode) { should cmp '0755' }
  its(:content) { should include 'Redirecting to cinc-auditor...' }
end

describe file('/usr/bin/inspec') do
  it { should be_symlink }
  its(:link_path) { should eq '/opt/cinc-auditor/bin/cinc-auditor-wrapper' }
end
