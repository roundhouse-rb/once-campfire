# Native view caches share one byte budget across every database generation.
class FragmentCache
  # Its own class, so cache instrumentation can tell its reads from Rails.cache's.
  class Store < ActiveSupport::Cache::MemoryStore; end

  STORE = Store.new(size: 64.megabytes)
  STORE_NAME = Store.name
  private_constant :STORE

  def self.store
    STORE
  end

  def self.transaction_open?
    ActiveRecord::Base.connection_pool.with_connection(&:transaction_open?)
  end
end
