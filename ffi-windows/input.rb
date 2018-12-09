require "ffi"
require "ffi-windows/api/user32"

module FFI
  module Windows
  
    class Keyboard
      
      include API::Kernel32
      extend API::Kernel32
      
      include API::User32
      extend API::User32
      
      def self.press(ids, direction = :down)
        ids = Array(ids)
        length = ids.length
        return 0 if ids.length <= 0
        
        buffer = FFI::MemoryPointer.new(INPUT, length)
        inputs = length.times.collect do | i |
          INPUT.new(buffer + i * INPUT.size)
        end
        
        ids.each_with_index do | id, i |
          code = VK_CODES[id]
          raise("Invalid keyboard key id #{id}.") if code == nil
          inputs[i][:type] = INPUT_KEYBOARD
          inputs[i][:union][:ki][:wVk] = code
          inputs[i][:union][:ki][:dwFlags] = direction == :up ? KEYEVENTF_KEYUP : 0
        end
        
        result = SendInput(length, buffer, INPUT.size)
        raise("Failed to send input: #{LastError.error}") if result == 0
        return result
      end
      
      def self.tap(ids, wait = 0)
        ids = Array(ids)
        self.press(ids, :down)
        if wait <= 0
          self.press(ids, :up)
        else
          ::Thread.new do
            sleep(wait)
            self.press(ids, :up)
          end
        end
        return ids.length
      end
      
      def self.pressed?(id)
        if id.kind_of?(Array)
          id.each do | id |
            return false if state(id) == 0
          end
          return true
        end
        return state(id) != 0
      end
      
      def self.state(id)
        if id != nil
          code = VK_CODES[id]
          raise("Invalid keyboard key id #{id}.") if code == nil
          return GetAsyncKeyState(code)
        end
        
        begin
          buffer = MemoryPointer.new(BYTE, 0x100)
          result = GetKeyboardState(buffer)
          raise("Failed to get keyboard state: #{LastError.error}") if result == 0
          state = buffer.get_array_of_uchar(0, 0x100)
          return state
        ensure
          buffer.free
        end
      end
      
    end
    
  end
end