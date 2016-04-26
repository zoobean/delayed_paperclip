require 'resque'

module DelayedPaperclip
  module Jobs
    class Resque
      def self.enqueue_delayed_paperclip(instance_klass, instance_id, attachment_name)
        @queue = instance_klass.constantize.paperclip_definitions[attachment_name][:delayed][:queue]
        ::Resque.enqueue(self, instance_klass, instance_id, attachment_name)
      end

      def self.perform(instance_klass, instance_id, attachment_name)
        DelayedPaperclip.process_job(instance_klass, instance_id, attachment_name)
      end
    end
  end
end
