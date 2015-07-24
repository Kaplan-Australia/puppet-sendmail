require 'spec_helper'

describe 'sendmail::genericstable::entry' do
  let(:title) { 'user@example.com' }

  let(:facts) do
    { :operatingsystem => 'Debian' }
  end

  let(:params) do
    { :value => 'user@example.org' }
  end

  it {
    should contain_class('sendmail::params')
    should contain_class('sendmail::makeall')
    should contain_class('sendmail::genericstable::file')
    should contain_augeas('/etc/mail/genericstable-user@example.com') \
            .that_requires('Class[sendmail::genericstable::file]') \
            .that_notifies('Class[sendmail::makeall]')
  }

  context 'Missing value' do
    let(:params) do
      { :ensure => 'present' }
    end

    it {
      expect {
        should compile
      }.to raise_error(/value must be set when creating an genericstable entry/)
    }
  end
end
