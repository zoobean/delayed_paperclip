require 'sidekiq/worker'

module DelayedPaperclip
  module Jobs
    class Sidekiq
      include ::Sidekiq::Worker

      def self.enqueue_delayed_paperclip(instance_klass, instance_id, attachment_name)
        queue_name = instance_klass.constantize.paperclip_definitions[attachment_name][:delayed][:queue]
        # Sidekiq >= 4.1.0
        if respond_to?(:set)
          set(:queue => queue_name)
        else
          sidekiq_options :queue => queue_name
        end
        perform_async(instance_klass, instance_id, attachment_name)
      end

      def perform(instance_klass, instance_id, attachment_name)
        DelayedPaperclip.process_job(instance_klass, instance_id, attachment_name)
      end
    end
  end
end
