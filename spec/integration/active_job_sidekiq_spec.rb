require 'spec_helper'
require 'sidekiq/api'

describe "ActiveJob with Sidekiq backend" do

if defined? ActiveJob
  before :all do
    DelayedPaperclip.options[:background_job_class] = DelayedPaperclip::Jobs::ActiveJob
    ActiveJob::Base.logger = nil
    ActiveJob::Base.queue_adapter = :sidekiq
  end

  let(:dummy) { Dummy.new(:image => File.open("#{ROOT}/spec/fixtures/12k.png")) }

  describe "integration tests" do
    include_examples "base usage"
  end
end

  def process_jobs
    Sidekiq::Queue.new(:paperclip).each do |job|
      worker = job.klass.constantize.new
      args   = job.args
      begin
        worker.perform(*args)
      rescue # Assume sidekiq handle exception properly
      end
      job.delete
    end
  end

  def jobs_count
    Sidekiq::Queue.new(:paperclip).size
  end
end
