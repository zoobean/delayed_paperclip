require 'spec_helper'
require 'sidekiq/api'

describe "ActiveJob with Sidekiq backend" do

if defined? ActiveJob
  before :all do
    DelayedPaperclip.options[:background_job_class] = DelayedPaperclip::Jobs::ActiveJob
    ActiveJob::Base.logger = nil
    ActiveJob::Base.queue_adapter = :sidekiq
  end

  before :each do
    Sidekiq::Queues["paperclip"].clear
  end

  let(:dummy) { Dummy.new(:image => File.open("#{ROOT}/spec/fixtures/12k.png")) }

  describe "integration tests" do
    include_examples "base usage"
  end
end

  def process_jobs
    Sidekiq::Queues["paperclip"].each do |job|
      worker = job["class"].constantize.new
      args   = job["args"]
      begin
        worker.perform(*args)
      rescue # Assume sidekiq handle exception properly
      end
    end
  end

  def jobs_count
    Sidekiq::Queues["paperclip"].size
  end
end
