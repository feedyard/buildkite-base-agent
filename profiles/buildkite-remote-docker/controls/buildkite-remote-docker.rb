control 'packages' do
  impact 1.0
  title 'confirm package installation'
  desc 'confirm all desired packages are installed'
  describe command('apk info') do
    its('stdout') { should include ('bash') }
    its('stdout') { should include ('git') }
    its('stdout') { should include ('openssh') }
    its('stdout') { should include ('curl') }
    its('stdout') { should include ('tar') }
    its('stdout') { should include ('gzip') }
    its('stdout') { should include ('ca-certificates') }
  end
end

control 'bash version' do
  impact 1.0
  title 'confirm bash version installed'
  desc 'confirm version reported bash git matches the desired version'
  describe command('bash --version') do
    its('stdout') { should include ('5.0') }
  end
end

control 'git version' do
  impact 1.0
  title 'confirm git version installed'
  desc 'confirm version reported by git matches the desired version'
  describe command('git version') do
    its('stdout') { should include ('2.22') }
  end
end

control 'openssh version' do
  impact 1.0
  title 'confirm openssh version installed'
  desc 'confirm version reported by openssh matches the desired version'
  describe command('ssh -V') do
    its('stderr') { should include ('8.0') }
  end
end

control 'curl version' do
  impact 1.0
  title 'confirm curl version installed'
  desc 'confirm version reported by curl matches the desired version'
  describe command('curl --version') do
    its('stdout') { should include ('7.66') }
  end
end

control 'tar version' do
  impact 1.0
  title 'confirm tar version installed'
  desc 'confirm version reported by tar matches the desired version'
  describe command('tar --version') do
    its('stdout') { should include ('1.32') }
  end
end

control 'gzip version' do
  impact 1.0
  title 'confirm gzip version installed'
  desc 'confirm version reported by gzip matches the desired version'
  describe command('gzip --version') do
    its('stdout') { should include ('1.10') }
  end
end


control 'buildkite-agent version' do
  impact 1.0
  title 'confirm buildkite-agent version installed'
  desc 'confirm version reported by buildkite-agent matches the desired version'
  describe command('buildkite-agent --version') do
    its('stdout') { should include ('3.13.2') }
  end
end


control 'buildkite path/file structure' do
  impact 1.0
  title 'confirm buildkite-agent path/file structure'
  desc 'confirm path/file structure exist to support custmer buildkite pipeline hooks and plugins'
  describe file('/buildkite/builds') do
    it { should be_directory }
  end
  describe file('/buildkite/hooks') do
    it { should be_directory }
  end
  describe file('/buildkite/plugins') do
    it { should be_directory }
  end
  describe file('/buildkite/buildkite-agent.cfg') do
    it { should exist }
  end
end
