describe command('echo test > /tmp/testfile') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq '' }
end

describe file('/tmp/testfile') do
  it { should be_file }
  its(:content) { should include 'test' }
end
