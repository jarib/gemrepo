require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GemRepo do
  before(:all) { GemRepo.set :gemdir, gemdir }
  after { clear_gemdir }

  it "should succeed if the pushed gem is valid" do
    current_gems.should be_empty
    current_index.should be_nil

    post "/api/v1/gems", sample_gem

    last_response.should be_ok
    last_response.body.should == "Successfully registered gem: sample-0.0.1"

    current_gems.size.should == 1
    current_index.should_not be_nil
  end

  it "should fail if the pushed gem is invalid" do
    post "/api/v1/gems"

    last_response.status.should == 422
    last_response.body.should == "invalid gem"
  end

  it "should fail if the pushed gem already exists" do
    create_index
    current_gems.size.should == 1


    post "/api/v1/gems", sample_gem

    p current_gems

    last_response.status.should == 422
    last_response.body.should == "gem already exists"
    current_gems.size.should == 1
  end

  it "should serve the index" do
    create_index

    get "/yaml"

    last_response.should be_ok
    YAML.load(last_response.body).should be_kind_of(Gem::SourceIndex)
  end

end
