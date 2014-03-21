require "spec_helper"

describe BetaRequestNotifier do
  describe "new_request_notifier" do
    let(:mail) { BetaRequestNotifier.new_request_notifier }

    it "renders the headers" do
      mail.subject.should eq("New request notifier")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "invitation_notifier" do
    let(:mail) { BetaRequestNotifier.invitation_notifier }

    it "renders the headers" do
      mail.subject.should eq("Invitation notifier")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
