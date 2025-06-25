# config/initializers/noticed.rb
# Extend Noticed models with our custom methods

Rails.application.config.to_prepare do
  # Add convenience methods to access event data easily
  Noticed::Notification.class_eval do
    # Delegate methods to event for easier access in views
    delegate :title, :message, :icon, :url, :notification_type,
             :actor, :target_list, :previous_status, :new_status, :action_type,
             to: :event, allow_nil: true

    # Add convenience methods that might not be in v2.6
    def read?
      read_at.present?
    end

    def unread?
      read_at.nil?
    end

    def seen?
      seen_at.present?
    end

    def unseen?
      seen_at.nil?
    end

    def mark_as_read!
      update!(read_at: Time.current) unless read?
    end

    def mark_as_seen!
      update!(seen_at: Time.current) unless seen?
    end
  end
end
