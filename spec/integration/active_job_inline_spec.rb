require 'spec_helper'

describe "ActiveJob inline" do
  before :each do
    ActiveJob::Base.queue_adapter = :inline
    ActiveJob::Base.logger = nil
  end

  let(:dummy) { Dummy.new(:image => File.open("#{ROOT}/fixtures/12k.png")) }

  describe "perform job" do
    before :each do
      DelayedPaperclip.options[:url_with_processing] = true
      reset_dummy
    end

    it "performs a job" do
      dummy.image = File.open("#{ROOT}/fixtures/12k.png")
      Paperclip::Attachment.any_instance.expects(:reprocess!)
      dummy.save!
    end
  end
end
