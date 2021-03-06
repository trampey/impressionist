# Note
# If impressionist_counter_cache_options[:counter_cache] is false(default)
# it won't event run this class
module Impressionist

  class UpdateCounters
    attr_reader :receiver, :klass

    def initialize(receiver)
      @receiver = receiver
      @klass = receiver.class
    end

    def update
      klass.
      update_counters(id, column_name => result)
    end

    private

    def result
      impressions_total - impressions_cached
    end

    # Count impressions based on unique_filter
    # default is :ip_address when unique: true
    def impressions_total
      receiver.impressionist_count filter
    end

    # Fetch impressions from a receiver's column
    def impressions_cached
      receiver.send(column_name) || 0
    end

    def filter
      {:filter => unique_filter}
    end

    # :filter gets assigned to :ip_address as default
    # One could do
    # is_impressionable :counter_cache => true,
    # :unique => :any_other_filter
    def unique_filter
      Symbol === unique ?
      unique :
      :ip_address
    end

    def unique
      cache_options[:unique]
    end

    def column_name
      cache_options[:column_name].to_s
    end

    def cache_options
      klass.
      impressionist_counter_cache_options
    end

    def id
      receiver.id
    end

  end

end
