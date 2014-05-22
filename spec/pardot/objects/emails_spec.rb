require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Pardot::Objects::Emails do

  before do
    @client = create_client
  end

  def sample_email
    %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
      <email>
        <name>My Email</name>
      </email>
    </rsp>)
  end

  def sample_send_to_prospect
    %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
      <email>
        <name>My Email</name>
      </email>
    </rsp>)
  end

  def sample_send_to_list
    %(<?xml version="1.0" encoding="UTF-8"?>\n<rsp stat="ok" version="1.0">
      <email>
        <name>My Email</name>
      </email>
    </rsp>)
  end

  before do
    @client = create_client
  end

  it "should take in the email ID" do
    fake_get "/api/email/version/3/do/read/id/12?user_key=bar&api_key=my_api_key&format=simple", sample_email
    @client.emails.read_by_id(12).should == {"name" => "My Email"}
  end

  it 'should send to a prospect' do
    fake_post '/api/email/version/3/do/send/prospect_id/42?campaign_id=765&email_template_id=86&user_key=bar&api_key=my_api_key&format=simple', sample_send_to_prospect
    @client.emails.send_to_prospect(42, :campaign_id => 765, :email_template_id => 86).should == {"name" => "My Email"}
  end

  it 'should send to a list' do
    fake_post '/api/email/version/3/do/send?email_template_id=200&list_ids[]=235&campaign_id=654&user_key=bar&api_key=my_api_key&format=simple', sample_send_to_list
    @client.emails.send_to_list(:email_template_id => 200, 'list_ids[]' => 235, :campaign_id => 654).should == {"name" => "My Email"}
  end

end