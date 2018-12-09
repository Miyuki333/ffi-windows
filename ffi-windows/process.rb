require "ffi"
require "ffi-windows/api/kernel32"

module FFI
  module Windows

    class Process
      
      include API::Kernel32
      extend API::Kernel32
      
      attr_reader :handle
      
      def initialize(handle)
        @handle = handle
      end
      
      def close
        return CloseHandle(@handle)
      end
      
      def quit
        return Process.quit(self.pid)
      end
      
      def kill(code = 0)
        return Process.kill(self.pid)
      end
      
      def pid
        return GetProcessId(@handle)
      end
      
      def entry
        pid = self.pid
        return Process.find { | entry | entry.pid == pid }
      end
      
      def name
        return File.basename(full_name)
      end
      
      def path
        return File.dirname(full_name)
      end
      
      def full_name
        begin
          name = MemoryPointer.new(WCHAR, MAX_PATH)
          size = MemoryPointer.new(DWORD)
          size.put(DWORD, 0, MAX_PATH * 2)
          
          result = QueryFullProcessImageName(@handle, nil, name, size)
          
          raise("Failed to get process name: #{LastError.error}") if result == 0
          
          return name.to_ws.encode("utf-8")
        ensure
          name.free
          size.free
        end
      end
      
      def threads
        return Thread.list(self.pid)
      end
      
      def alive?
        begin
          code = FFI::MemoryPointer.new(DWORD)
          
          result = GetExitCodeProcess(@handle, code)
          raise("Failed to check if process is alive: #{LastError.error}") if result == 0
          
          return code.get(DWORD, 0) == STILL_ACTIVE
        ensure
          code.free
        end
      end
      
      def wait(time = nil)
        start_time = Time.now
        time == nil ? time = INFINITE : time = (time * 1000).to_i
        
        result = WaitForSingleObject(@handle, time)
        raise("Failed to wait for process: #{LastError.error}") if result == WAIT_FAILED
        
        return ((Time.now - start_time) * 1000).to_i
      end
      
      def self.create(command, options = {})
        name = nil
        command = command.to_s
        flags = options[:flags].to_i
        flags |= CREATE_NO_WINDOW if options[:no_window] == true
        directory = options[:directory] ? options[:directory].to_s.gsub("/", "\\") : nil
        
        startup_info = STARTUPINFO.new
        process_info = PROCESS_INFORMATION.new
        
        result = CreateProcess(name, command, nil, nil, 0, flags, nil, directory, startup_info, process_info)
        raise("Failed to create process: #{LastError.error}") if result == 0
        
        CloseHandle(process_info.thread)
      
        return Process.new(process_info.process)
      end
      
      def self.open(pid, access = PROCESS_ALL_ACCESS, inherit_handle = false)
        handle = OpenProcess(access, (inherit_handle ? TRUE : FALSE), pid)
        raise("Failed to open process: #{LastError.error}") if handle.null?
        Process.new(handle)
      end
      
      def self.quit(pid)
        Thread.list(pid).each do | entry |
          API::User32.PostThreadMessageW(entry.tid, API::User32::WM_QUIT, nil, nil)
        end
      end
      
      def self.kill(pid, code = 0)
        proc = self.open(pid, PROCESS_TERMINATE)
        result = TerminateProcess(proc.handle, code.to_i)
        error = result == 0 ? LastError.error : 0 
        raise("Failed to kill process: #{error}") if error != 0
        proc.close
        return result
      end
      
      def self.list
        list = []
        handle = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
        entry = PROCESSENTRY32.new
        
        begin
          return list if Process32First(handle, entry) <= 0
          list.push(entry.dup)
          
          while Process32Next(handle, entry) > 0
            list.push(entry.dup)
          end
        ensure
          CloseHandle(handle)
        end
        
        return list
      end
      
      def self.find(limit = nil, &block)
        handle = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
        entry = PROCESSENTRY32.new
        list = []
        return if limit && limit <= 0
        
        begin
          return nil if Process32First(handle, entry) <= 0
          list.push(entry.dup) if block.call(entry) == true 
          
          while Process32Next(handle, entry) > 0 && (limit == nil || list.length <= limit)
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