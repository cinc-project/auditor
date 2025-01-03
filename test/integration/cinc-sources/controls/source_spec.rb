control 'Validate source tarballs' do
  impact 1.0
  title 'Ensure source tarball are correct'
  desc 'Ensure the tarballs match their respective shasum'

  describe command 'bash -c "cd source/ && sha256sum -c cinc-auditor-[0-9]*.tar.xz.sha256sum"' do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /OK$/ }
  end
  describe command 'bash -c "cd source/ && sha512sum -c cinc-auditor-[0-9]*.tar.xz.sha512sum"' do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /OK$/ }
  end
end
