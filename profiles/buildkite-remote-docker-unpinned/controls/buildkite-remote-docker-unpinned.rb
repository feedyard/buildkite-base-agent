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
