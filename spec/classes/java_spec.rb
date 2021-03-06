require 'spec_helper'

describe "java" do
  let(:params) {
    {
      :jre_url     => 'https://s3.amazonaws.com/boxen-downloads/java/jre-7u51-macosx-x64.dmg',
      :jre_package => 'jre-5u51.dmg',
      :jdk_url     => 'https://s3.amazonaws.com/boxen-downloads/java/jdk-7u51-macosx-x64.dmg',
      :jdk_package => 'jdk-5u51.dmg',
      :wrapper     => '/test/boxen/bin/java',
    }
  }
  let(:facts) { default_test_facts }

  it do
    should include_class('boxen::config')

    should contain_package('jre-7u51.dmg').with({
      :ensure   => 'present',
      :alias    => 'java-jre',
      :provider => 'pkgdmg',
      :source   => 'https://s3.amazonaws.com/boxen-downloads/java/jre-7u51-macosx-x64.dmg'
    })

    should contain_package('jdk-7u51.dmg').with({
      :ensure   => 'present',
      :alias    => 'java',
      :provider => 'pkgdmg',
      :source   => 'https://s3.amazonaws.com/boxen-downloads/java/jdk-7u51-macosx-x64.dmg'
    })

    should contain_file('/test/boxen/bin/java').with({
      :source  => 'puppet:///modules/java/java.sh',
      :mode    => '0755',
      :require => 'Package[java]'
    })
  end
end
