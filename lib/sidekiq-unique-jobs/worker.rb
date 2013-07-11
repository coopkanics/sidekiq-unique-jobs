module Sidekiq
  module Worker
    def unlock(*args)
      klass, queue = self.class, klass.get_sidekiq_options['queue']
      payload = SidekiqUniqueJobs::PayloadHelper.get_payload(klass, queue, args)
      Sidekiq.redis {|conn| conn.del(payload) }
    end
  end
end
