require 'spec_helper'

describe 'certs::qpid_client' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let :facts do facts end

      describe "without parameters" do
        let :pre_condition do
          'include ::certs'
        end

        it { is_expected.to compile.with_all_deps }

        it do
          is_expected.to contain_cert('foo.example.com-qpid-client-cert')
            .with_hostname('foo.example.com')
            .with_cname([])
        end

        it do
          is_expected.to contain_key_bundle('/etc/pki/katello/qpid_client_striped.crt')
            .with_key_pair('Cert[foo.example.com-qpid-client-cert]')
        end

        it { is_expected.to contain_file('/etc/pki/katello/qpid_client_striped.crt') }
      end
    end
  end
end
