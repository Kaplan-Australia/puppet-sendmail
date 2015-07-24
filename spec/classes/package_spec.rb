require 'spec_helper'

describe 'sendmail::package' do

  context 'On Debian with defaults' do
    let(:facts) do
      { :operatingsystem => 'Debian' }
    end

    it { should contain_package('sendmail').with_ensure('present') }
    it { should contain_package('bsd-mailx').with_ensure('present') }
  end

  context 'On Debian with package_ensure => latest' do
    let(:facts) do
      { :operatingsystem => 'Debian' }
    end

    let(:params) do
      { :package_ensure => 'latest' }
    end

    it { should contain_package('sendmail').with_ensure('latest') }
    it { should contain_package('bsd-mailx').with_ensure('present') }
  end

  context 'On Debian with package_manage => false' do
    let(:facts) do
      { :operatingsystem => 'Debian' }
    end

    let(:params) do
      { :package_manage => false }
    end

    it { should_not contain_package('sendmail') }
  end

  context 'On Debian with auxiliary_packages defined' do
    let(:facts) do
      { :operatingsystem => 'Debian' }
    end

    let(:params) do
      { :auxiliary_packages => [ 'foo', 'bar' ] }
    end

    it {
      should contain_package('foo')
      should contain_package('bar')
    }
  end
end
