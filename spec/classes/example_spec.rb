require 'spec_helper'

describe 'dotcms' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "dotcms class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('dotcms::params') }
          it { is_expected.to contain_class('dotcms::install').that_comes_before('dotcms::config') }
          it { is_expected.to contain_class('dotcms::config') }
          it { is_expected.to contain_class('dotcms::service').that_subscribes_to('dotcms::config') }

          it { is_expected.to contain_service('dotcms') }
          it { is_expected.to contain_package('dotcms').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'dotcms class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('dotcms') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
