require "ffi"
require "ffi-windows/api/kernel32"
require "ffi-windows/api/user32"

module FFI
  module Windows

    class Window
      
      include API
      extend API
      
      include API::Kernel32
      extend API::Kernel32
      
      include API::User32
      extend API::User32
      
      attr_reader :handle
      alias_method :hwnd, :handle
      attr_reader :fullscreen
      
      def initialize(handle)
        @handle = handle
        @fullscreen = false
      end
      
      def close
        return CloseHandle(@handle)
      end
      
      def pos(type = nil)
        return Window.pos(@handle, nil, type)
      end
      
      def pos=(coords)
        return Window.pos(@handle, coords, nil)
      end
      
      def min_pos=(coords)
        return Window.pos(@handle, coords, :min)
      end
      
      def max_pos=(coords)
        return Window.pos(@handle, coords, :max)
      end
      
      def style
        return Window.style(@handle)
      end
      
      def style=(styles)
        return Window.style(@handle, styles)
      end
      
      def title
        return Window.title(@handle)
      end
      
      def title=(title)
        return Window.title(@handle, title)
      end
      
      def tid
        return self.tid(@handle)
      end
      
      def pid
        return self.pid(@handle)
      end
      
      def fullscreen=(bool)
        return bool if bool == @fullscreen
        
        if bool == true
          
          @windowed_style = self.style
          self.style = @windowed_style - [:caption, :border, :dlgframe, :thickframe, :dlgmodalframe, :windowedge, :clientedge, :staticedge]
          
          @windowed_pos = self.pos
          monitor = MonitorFromWindow(@handle, 0)
          mi = MONITORINFO.new
          unless GetMonitorInfo(monitor, mi)
            raise("Failed to get monitor info: #{LastError.error}.")
          end
          self.pos = [ mi[:rcMonitor][:left], mi[:rcMonitor][:top], mi[:rcMonitor][:right] - mi[:rcMonitor][:left], mi[:rcMonitor][:bottom] - mi[:rcMonitor][:top] ]
          
          return @fullscreen = true
          
        else
          
          self.style = @windowed_style
          self.pos = @windowed_pos
          return @fullscreen = false
          
        end
      end
      
      def self.pos(hwnd, coords = nil, type = nil)
        placement = WINDOWPLACEMENT.new
        unless GetWindowPlacement(hwnd, placement) > 0
          raise("Failed to get window placement: #{LastError.error}.")
        end
        
        if coords == nil
        
          case type
          when :min
            return [ placement[:ptMinPosition][:x], placement[:ptMinPosition][:y] ]
          when :max
            return [ placement[:ptMaxPosition][:x], placement[:ptMaxPosition][:y] ]
          else
            return [ placement[:rcNormalPosition][:left], placement[:rcNormalPosition][:top], placement[:rcNormalPosition][:right], placement[:rcNormalPosition][:bottom] ]
          end
        
        else
          
          case type
          when :min
            placement[:flags] |= WPF_SETMINPOSITION
            placement[:ptMinPosition][:x] = coords[0]
            placement[:ptMinPosition][:y] = coords[1]
          when :max
            placement[:ptMaxPosition][:x] = coords[0]
            placement[:ptMaxPosition][:y] = coords[1]
          else
            coords[2] ||= placement[:rcNormalPosition][:right] + (coords[0] - placement[:rcNormalPosition][:left])
            coords[3] ||= placement[:rcNormalPosition][:bottom] + (coords[1] - placement[:rcNormalPosition][:top])
            placement[:rcNormalPosition][:left] = coords[0]
            placement[:rcNormalPosition][:top] = coords[1]
            placement[:rcNormalPosition][:right] = coords[2]
            placement[:rcNormalPosition][:bottom] = coords[3]
          end
          
          unless SetWindowPlacement(hwnd, placement) > 0
            raise("Failed to set window placement: #{LastError.error}.")
          end
          
          return coords
          
        end
      end
      
      def self.style(hwnd, styles = nil)
        if styles == nil
          
          styles = []
      
          long = GetWindowLong(hwnd, GWL_STYLE)
          WINDOW_STYLES.each { | style , value | styles.push(style) if long & value == value }
          
          long = GetWindowLong(hwnd, GWL_EXSTYLE)
          WINDOW_STYLES_EX.each { | style, value | styles.push(style) if long & value == value }

          return styles
          
        else
          
          styles = Array(styles)
        
          long = 0
          styles.each { | style | long |= (WINDOW_STYLES[style] || 0) }
          SetWindowLong(hwnd, GWL_STYLE, long)
          
          long = 0
          styles.each { | style | long |= (WINDOW_STYLES_EX[style] || 0) }
          SetWindowLong(hwnd, GWL_EXSTYLE, long)
          
          return style(hwnd)
        
        end
      end
      
      def self.title(hwnd, title = nil)
        if title == nil
          
          begin
            buffer = FFI::MemoryPointer.new(WCHAR, 0xFFF)
            GetWindowText(hwnd, buffer, buffer.size)
            return buffer.to_ws.encode("utf-8")
          ensure
            buffer.free
          end
          
        else
          
          SetWindowText(hwnd, title)
          
        end
      end
      
      def self.list(desktop = nil)
        list = []
        
        callback = Proc.new do | hwnd, lparam |
          list.push(Window.new(hwnd))
          next TRUE
        end
        
        unless EnumDesktopWindows(desktop, callback, nil) > 0
          raise("Could not enumerate windows: #{LastError.error}.")
        end
        
        return list
      end
      
      def self.find(limit = nil, desktop = nil, &block)
        list = []
        
        callback = Proc.new do | hwnd, lparam |
          window = Window.new(hwnd)
          list.push(window) if block.call(window) == true
          next FALSE if limit && list.length >= limit
          next TRUE
        end
        
        unless EnumDesktopWindows(desktop, callback, nil) > 0 || list.length >= limit
          raise("Could not enumerate windows: #{LastError.error}.")
        end
        
        return nil if list.empty?
        return list[0] if limit == 1
        return list
      end
      
      def self.tid(hwnd)
        return GetWindowThreadProcessId(hwnd, nil)
      end
      
      def self.pid(hwnd)
        begin
          lpdw = FFI::MemoryPointer.new(DWORD)
          GetWindowThreadProcessId(hwnd, lpdw)
          return lpdw.get(DWORD, 0)
        ensure
          lpdw.free
        end
      end
      
      def self.messagebox(text, options = {})
        owner = options[:owner] || options[:parent]
        caption = options[:caption] || options[:title] || ""
        flags = 0
        
        case options[:buttons]
        when :okaycancel
          flags |= MB_OKCANCEL
        when :abortretrycancel
          flags |= MB_ABORTRETRYIGNORE
        when :yesnocancel
          flags |= MB_YESNOCANCEL
        when :yesno
          flags |= MB_YESNO
        when :retrycancel
          flags |= MB_RETRYCANCEL
        when :canceltrycontinue
          flags |= MB_CANCELTRYCONTINUE
        end
          
        case options[:icon]
        when :information
          flags |= MB_ICONINFORMATION
        when :asterisk
          flags |= MB_ICONASTERISK
        when :warning
          flags |= MB_ICONWARNING
        when :exclamation
          flags |= MB_ICONEXCLAMATION
        when :error
          flags |= MB_ICONERROR
        when :question
          flags |= MB_ICONQUESTION
        when :hand
          flags |= MB_ICONHAND
        when :user
          flags |= MB_USERICON
        end
        
        case options[:defbutton]
        when 1
          flags |= MB_DEFBUTTON1
        when 2
          flags |= MB_DEFBUTTON2
        when 3
          flags |= MB_DEFBUTTON3
        when 4
          flags |= MB_DEFBUTTON4
        end
        
        case options[:modal]
        when :app
          flags |= MB_APPLMODAL
        when :system
          flags |= MB_SYSTEMMODAL
        when :task
          flags |= MB_TASKMODAL
        end
        
        flags |= MB_HELP if options[:help]
        flags |= MB_DEFAULT_DESKTOP_ONLY if options[:defaultdesktoponly]
        flags |= MB_RIGHT if options[:right]
        flags |= MB_RTLREADING if options[:rtlreading]
        flags |= MB_SETFOREGROUND if options[:setforeground]
        flags |= MB_TOPMOST if options[:topmost]
        flags |= MB_SERVICE_NOTIFICATION if options[:servicenotification]
        
        return MessageBox(owner, text.to_s, caption, flags)
      end

    end
    
  end
end