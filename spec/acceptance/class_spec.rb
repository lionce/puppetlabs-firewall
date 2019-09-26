require 'spec_helper_acceptance'

describe 'firewall class' do
  before(:all) do
    if os[:family] == 'ubuntu' || os[:family] == 'debian'
      run_shell("sed -i '/mesg n/c\\test -t 0 && mesg n || true' ~/.profile")
      run_shell("sed -i '/mesg n || true/c\\test -t 0 && mesg n || true' ~/.profile")
    end
  end

  it 'runs successfully' do
    pp = "class { 'firewall': }"
    expect(idempotent_apply(pp).exit_code).to be_zero
  end

  it 'ensure => stopped:' do
    pp = "class { 'firewall': ensure => stopped }"
    expect(idempotent_apply(pp).exit_code).to be_zero
  end

  it 'ensure => running:' do
    pp = "class { 'firewall': ensure => running }"
    expect(idempotent_apply(pp).exit_code).to be_zero
  end
end
