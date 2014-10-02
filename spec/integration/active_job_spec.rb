require 'spec_helper'

describe "ActiveJob inline" do

  before :all do
    DelayedPaperclip.options[:background_job_class] = DelayedPaperclip::Jobs::ActiveJob
  end

  let(:dummy) { Dummy.new(:image => File.open("#{ROOT}/spec/fixtures/12k.png")) }

if Rails.version.to_f >= 4.2
  describe "perform job" do
    before :each do
      DelayedPaperclip.options[:url_with_processing] = true
      reset_dummy
    end

    it "performs a job" do
      dummy.image = File.open("#{ROOT}/spec/fixtures/12k.png")
      Paperclip::Attachment.any_instance.expects(:reprocess!)
      dummy.save!
    end
  end
end
end