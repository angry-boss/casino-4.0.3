require_relative '../../spec_helper'
require_relative '../../../lib/casino/authenticator'
#require 'casino/authenticator'
#require 'spec_helper'
describe CASino::Authenticator do
  subject {
    CASino::Authenticator.new
  }

  context '#validate' do
    it 'raises an error' do
      expect { subject.validate(nil, nil) }.to raise_error(NotImplementedError)
    end
  end
end
