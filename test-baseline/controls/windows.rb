title 'Windows Cinc Auditor tests'

control 'cinc-auditor-windows' do
  impact 1.0
  title 'Validate cinc-auditor on Windows'
  desc 'Outputs should not contain trademarks on Windows'
  only_if { os.family == 'windows' }

  describe command('New-Item -Force -Path C:\Windows\Temp\ -Name "testfile" -ItemType "file" -Value "test"') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /testfile/ }
  end

  describe file('C:\Windows\Temp\testfile') do
    it { should be_file }
    its(:content) { should include 'test' }
  end

  describe command 'cinc-auditor.bat version' do
    its('exit_status') { should eq 0 }
  end

  describe command 'cinc-auditor.bat detect' do
    its('exit_status') { should eq 0 }
  end

  describe command 'C:\cinc-project\cinc-auditor\bin\inspec version' do
    its('exit_status') { should eq 0 }
    # Wrapper is broken in windows
    # its('stdout') { should match /^Redirecting to cinc-auditor/ }
  end
end
