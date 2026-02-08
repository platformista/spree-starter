
# Mock Spree::Store
module Spree
  class Store
    attr_accessor :url, :persisted
    def persisted?
      @persisted
    end
    
    def update_column(col, val)
      puts "update_column called with #{col}, #{val}"
      @url = val
    end
    
    def self.default
      @default
    end
    
    def self.default=(val)
      @default = val
    end
  end
end

# Logic from upsun.rb
def run_logic(url)
  store = Spree::Store.default
  # The fix:
  if store&.persisted? && store.url != url
    store.update_column(:url, url) 
    puts "Updated store url to #{url}"
  else
    puts "Did NOT update store url"
  end
end

puts "--- TEST 1: Store is nil ---"
Spree::Store.default = nil
run_logic("http://example.com")

puts "\n--- TEST 2: Store exists but not persisted (new record) ---"
s = Spree::Store.new
s.persisted = false
s.url = "http://original.com"
Spree::Store.default = s
run_logic("http://new.com")

puts "\n--- TEST 3: Store exists and persisted ---"
s.persisted = true
run_logic("http://new.com")
