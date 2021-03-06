require 'spec_helper'
require 'support/attachment_shared_context'

RSpec.describe PostmanMta::AttachmentsController, type: :controller do
  include_context 'attachment'

  it 'should show attachment' do
    get :show, params: { message_token: 'some_token', uuid: 'some_uuid' }

    expect(response).to be_success

    expect(response.headers['Content-Type']).to eq 'text/plain'
    expect(response.headers['Content-Disposition']).to match(/attachment[\w\W\s]+filename[\W]+file.txt/)
  end

  context 'url' do
    let(:get_attachment_success_body) { File.new('spec/stubs/attachments/attachment_with_url.json') }

    it 'should return internal redirection (X-Sendfile)' do
      get :show, params: { message_token: 'some_token', uuid: 'some_uuid' }

      expect(response).to be_success

      expect(response.headers['X-Accel-Redirect']).to eq '/private/s3.amazon.com/bucket/file/path?s=test'
      expect(response.headers['Content-Disposition']).to match(/attachment[\w\W\s]+filename[\W]+file.txt/)
    end
  end
end
