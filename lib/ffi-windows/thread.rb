require "ffi"
require "ffi-windows/api/kernel32"

module FFI
  module Windows
  
    class Thread
      
      include API::Kernel32
      extend API::Kernel32
      
      attr_reader :handle
      
      def initialize(handle)
        @handle = handle
      end
      
      def close
        return CloseHandle(@handle)
      end
      
      def self.open(tid, access = THREAD_ALL_ACCESS, inherit_handle = false)
        handle = OpenThread(access, (inherit_handle ? 1 : 0), tid)
        raise("Failed to open thread: #{LastError.error}") if handle == 0
        Thread.new(handle)
      end
      
      def self.current
        return GetCurrentThreadId()
      end
      
      def self.list(pid = nil)
        list = []
        handle = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0)
        entry = THREADENTRY32.new
        
        begin
          return list if Thread32First(handle, entry.to_ptr) <= 0
          list.push(entry.dup) if pid == nil || entry.pid == pid
          
          while Thread32Next(handle, entry.to_ptr) > 0
            list.push(entry.dup) if pid == nil || entry.pid == pid
          end
        ensure
          CloseHandle(handle)
        end
        
        return list
      end
      
      def self.find(limit = nil, &block)
        handle = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0)
        entry = THREADENTRY32.new
        list = []
        return if limit && limit <= 0
        
        begin
          return nil if Thread32First(handle, entry.to_ptr) <= 0
          list.push(entry.dup) if block.call(entry) == true 
          
          while Thread32Next(handle, entry.to_ptr) > 0 && (limit == nil || list.length <= limit)
            list.push(entry.dup) if block.call(entry) == true 
          end
        ensure
          CloseHandle(handle)
        end
        
        return nil if list.empty?
        return list[0] if limit == 1
        return list
      end

    end
    
  end
end