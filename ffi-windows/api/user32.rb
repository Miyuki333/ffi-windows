require "ffi"
require "ffi-windows/base"

module FFI
  module Windows
    module API
      module User32
    
        extend FFI::Library

        ffi_lib "user32"
        ffi_convention :stdcall
        
        #device
        
        CCHDEVICENAME = 32
        
        #key codes
        
        VK_LBUTTON = 0x01
        VK_RBUTTON = 0x02
        VK_CANCEL = 0x03
        VK_MBUTTON = 0x04

        VK_XBUTTON1 = 0x05
        VK_XBUTTON2 = 0x06

        VK_BACK = 0x08
        VK_TAB = 0x09

        VK_CLEAR = 0x0C
        VK_RETURN = 0x0D

        VK_SHIFT = 0x10
        VK_CONTROL = 0x11
        VK_MENU = 0x12
        VK_ALT = 0x12
        VK_PAUSE = 0x13
        VK_CAPITAL = 0x14

        VK_KANA = 0x15
        VK_HANGEUL = 0x15  # old name - should be here for compatibility 
        VK_HANGUL = 0x15
        VK_JUNJA = 0x17
        VK_FINAL = 0x18
        VK_HANJA = 0x19
        VK_KANJI = 0x19

        VK_ESCAPE = 0x1B

        VK_CONVERT = 0x1C
        VK_NONCONVERT = 0x1D
        VK_ACCEPT = 0x1E
        VK_MODECHANGE = 0x1F

        VK_SPACE = 0x20
        VK_PRIOR = 0x21
        VK_NEXT = 0x22
        VK_END = 0x23
        VK_HOME = 0x24
        VK_LEFT = 0x25
        VK_UP = 0x26
        VK_RIGHT = 0x27
        VK_DOWN = 0x28
        VK_SELECT = 0x29
        VK_PRINT = 0x2A
        VK_EXECUTE = 0x2B
        VK_SNAPSHOT = 0x2C
        VK_INSERT = 0x2D
        VK_DELETE = 0x2E
        VK_HELP = 0x2F

        VK_0 = 0x30
        VK_1 = 0x31
        VK_2 = 0x32
        VK_3 = 0x33
        VK_4 = 0x34
        VK_5 = 0x35
        VK_6 = 0x36
        VK_7 = 0x37
        VK_8 = 0x38
        VK_9 = 0x39

        VK_A = 0x41
        VK_B = 0x42
        VK_C = 0x43
        VK_D = 0x44
        VK_E = 0x45
        VK_F = 0x46
        VK_G = 0x47
        VK_H = 0x48
        VK_I = 0x49
        VK_J = 0x4A
        VK_K = 0x4B
        VK_L = 0x4C
        VK_M = 0x4D
        VK_N = 0x4E
        VK_O = 0x4F
        VK_P = 0x50
        VK_Q = 0x51
        VK_R = 0x52
        VK_S = 0x53
        VK_T = 0x54
        VK_U = 0x55
        VK_V = 0x56
        VK_W = 0x57
        VK_X = 0x58
        VK_Y = 0x59
        VK_Z = 0x5A

        VK_LWIN = 0x5B
        VK_RWIN = 0x5C
        VK_APPS = 0x5D

        VK_SLEEP = 0x5F

        VK_NUMPAD0 = 0x60
        VK_NUMPAD1 = 0x61
        VK_NUMPAD2 = 0x62
        VK_NUMPAD3 = 0x63
        VK_NUMPAD4 = 0x64
        VK_NUMPAD5 = 0x65
        VK_NUMPAD6 = 0x66
        VK_NUMPAD7 = 0x67
        VK_NUMPAD8 = 0x68
        VK_NUMPAD9 = 0x69

        VK_MULTIPLY = 0x6A
        VK_ADD = 0x6B
        VK_SEPARATOR = 0x6C
        VK_SUBTRACT = 0x6D
        VK_DECIMAL = 0x6E
        VK_DIVIDE = 0x6F

        VK_F1 = 0x70
        VK_F2 = 0x71
        VK_F3 = 0x72
        VK_F4 = 0x73
        VK_F5 = 0x74
        VK_F6 = 0x75
        VK_F7 = 0x76
        VK_F8 = 0x77
        VK_F9 = 0x78
        VK_F10 = 0x79
        VK_F11 = 0x7A
        VK_F12 = 0x7B
        VK_F13 = 0x7C
        VK_F14 = 0x7D
        VK_F15 = 0x7E
        VK_F16 = 0x7F
        VK_F17 = 0x80
        VK_F18 = 0x81
        VK_F19 = 0x82
        VK_F20 = 0x83
        VK_F21 = 0x84
        VK_F22 = 0x85
        VK_F23 = 0x86
        VK_F24 = 0x87

        VK_NUMLOCK = 0x90
        VK_SCROLL = 0x91

        VK_OEM_NEC_EQUAL = 0x92

        VK_OEM_FJ_JISHO = 0x92
        VK_OEM_FJ_MASSHOU = 0x93
        VK_OEM_FJ_TOUROKU = 0x94
        VK_OEM_FJ_LOYA = 0x95
        VK_OEM_FJ_ROYA = 0x96

        #only valid for GetAsyncKeyState and GetKeyState
        VK_LSHIFT = 0xA0
        VK_RSHIFT = 0xA1
        VK_LCONTROL = 0xA2
        VK_RCONTROL = 0xA3
        VK_LMENU = 0xA4
        VK_LALT = 0xA4
        VK_RMENU = 0xA5
        VK_RALT = 0xA5

        VK_BROWSER_BACK = 0xA6
        VK_BROWSER_FORWARD = 0xA7
        VK_BROWSER_REFRESH = 0xA8
        VK_BROWSER_STOP = 0xA9
        VK_BROWSER_SEARCH = 0xAA
        VK_BROWSER_FAVORITES = 0xAB
        VK_BROWSER_HOME = 0xAC

        VK_VOLUME_MUTE = 0xAD
        VK_VOLUME_DOWN = 0xAE
        VK_VOLUME_UP = 0xAF
        VK_MEDIA_NEXT_TRACK = 0xB0
        VK_MEDIA_PREV_TRACK = 0xB1
        VK_MEDIA_STOP = 0xB2
        VK_MEDIA_PLAY_PAUSE = 0xB3
        VK_LAUNCH_MAIL = 0xB4
        VK_LAUNCH_MEDIA_SELECT = 0xB5
        VK_LAUNCH_APP1 = 0xB6
        VK_LAUNCH_APP2 = 0xB7

        VK_OEM_1 = 0xBA
        VK_OEM_PLUS = 0xBB
        VK_OEM_COMMA = 0xBC
        VK_OEM_MINUS = 0xBD
        VK_OEM_PERIOD = 0xBE
        VK_OEM_2 = 0xBF
        VK_OEM_3 = 0xC0

        VK_OEM_4 =  0xDB
        VK_OEM_5 = 0xDC
        VK_OEM_6 = 0xDD
        VK_OEM_7 = 0xDE
        VK_OEM_8 = 0xDF

        VK_OEM_AX = 0xE1
        VK_OEM_102 = 0xE2
        VK_ICO_HELP = 0xE3
        VK_ICO_00 = 0xE4

        VK_PROCESSKEY = 0xE5

        VK_ICO_CLEAR = 0xE6

        VK_PACKET = 0xE7

        VK_OEM_RESET = 0xE9
        VK_OEM_JUMP = 0xEA
        VK_OEM_PA1 = 0xEB
        VK_OEM_PA2 = 0xEC
        VK_OEM_PA3 = 0xED
        VK_OEM_WSCTRL = 0xEE
        VK_OEM_CUSEL = 0xEF
        VK_OEM_ATTN = 0xF0
        VK_OEM_FINISH = 0xF1
        VK_OEM_COPY = 0xF2
        VK_OEM_AUTO = 0xF3
        VK_OEM_ENLW = 0xF4
        VK_OEM_BACKTAB = 0xF5

        VK_ATTN = 0xF6
        VK_CRSEL = 0xF7
        VK_EXSEL = 0xF8
        VK_EREOF = 0xF9
        VK_PLAY = 0xFA
        VK_ZOOM = 0xFB
        VK_NONAME = 0xFC
        VK_PA1 = 0xFD
        VK_OEM_CLEAR = 0xFE
        
        VK_CODES = {:lbutton => VK_LBUTTON,
        :rbutton => VK_RBUTTON,
        :cancel => VK_CANCEL,
        :mbutton=> VK_MBUTTON,

        :xbutton1 => VK_XBUTTON1,
        :xbutton2 => VK_XBUTTON2,

        :back => VK_BACK,
        :tab => VK_TAB,

        :clear => VK_CLEAR,
        :return => VK_RETURN,
        :enter => VK_RETURN,

        :shift => VK_SHIFT,
        :control => VK_CONTROL,
        :ctrl => VK_CONTROL,
        :menu => VK_MENU,
        :alt => VK_ALT,
        :pause => VK_PAUSE,
        :capital => VK_CAPITAL,
        :caps => VK_CAPITAL,
        :capslock => VK_CAPITAL,

        :kana => VK_KANA,
        :hangeul => VK_HANGEUL,
        :hangul => VK_HANGUL,
        :junja => VK_JUNJA,
        :final=> VK_FINAL,
        :hanja=> VK_HANJA,
        :kanji=> VK_KANJI,

        :escape => VK_ESCAPE,
        :esc => VK_ESCAPE,

        :convert => VK_CONVERT,
        :nonconvert => VK_NONCONVERT,
        :accept => VK_ACCEPT,
        :modechange => VK_MODECHANGE,

        :space => VK_SPACE,
        :prior => VK_PRIOR,
        :previous => VK_PRIOR,
        :prev => VK_PRIOR,
        :next => VK_NEXT,
        :end => VK_END,
        :home => VK_HOME,
        :left => VK_LEFT,
        :up => VK_UP,
        :right => VK_RIGHT,
        :down => VK_DOWN,
        :select => VK_SELECT,
        :print => VK_PRINT,
        :execute => VK_EXECUTE,
        :snapshot => VK_SNAPSHOT,
        :insert => VK_INSERT,
        :ins => VK_INSERT,
        :delete => VK_DELETE,
        :del => VK_DELETE,
        :help => VK_HELP,

        :"0" => VK_0,
        :zero => VK_0,
        :"1" => VK_1,
        :one => VK_1,
        :"2" => VK_2,
        :two => VK_2,
        :"3" => VK_3,
        :three => VK_3,
        :"4" => VK_4,
        :four => VK_4,
        :"5" => VK_5,
        :five => VK_5,
        :"6" => VK_6,
        :six => VK_6,
        :"7" => VK_7,
        :seven => VK_7,
        :"8" => VK_8,
        :eight => VK_8,
        :"9" => VK_9,
        :nine => VK_9,

        :a => VK_A,
        :b => VK_B,
        :c => VK_C,
        :d => VK_D,
        :e => VK_E,
        :f => VK_F,
        :g => VK_G,
        :h => VK_H,
        :i => VK_I,
        :j => VK_J,
        :k => VK_K,
        :l => VK_L,
        :m => VK_M,
        :n => VK_N,
        :o => VK_O,
        :p => VK_P,
        :q => VK_Q,
        :r => VK_R,
        :s => VK_S,
        :t => VK_T,
        :u => VK_U,
        :v => VK_V,
        :w => VK_W,
        :x => VK_X,
        :y => VK_Y,
        :z => VK_Z,

        :lwin => VK_LWIN,
        :lwindows => VK_LWIN,
        :rwin => VK_RWIN,
        :rwindows => VK_LWIN,
        :apps => VK_APPS,

        :sleep => VK_SLEEP,

        :numpad0 => VK_NUMPAD0,
        :pad0 => VK_NUMPAD0,
        :numpad1 => VK_NUMPAD1,
        :pad1 => VK_NUMPAD1,
        :numpad2 => VK_NUMPAD2,
        :pad2 => VK_NUMPAD2,
        :numpad3 => VK_NUMPAD3,
        :pad3 => VK_NUMPAD3,
        :numpad4 => VK_NUMPAD4,
        :pad4 => VK_NUMPAD4,
        :numpad5 => VK_NUMPAD5,
        :pad5 => VK_NUMPAD5,
        :numpad6 => VK_NUMPAD6,
        :pad6 => VK_NUMPAD6,
        :numpad7 => VK_NUMPAD7,
        :pad7 => VK_NUMPAD7,
        :numpad8 => VK_NUMPAD8,
        :pad8 => VK_NUMPAD8,
        :numpad9 => VK_NUMPAD9,
        :pad9 => VK_NUMPAD9,

        :multiply => VK_MULTIPLY,
        :asterisk => VK_MULTIPLY,
        :add => VK_ADD,
        :separator => VK_SEPARATOR,
        :subtract => VK_SUBTRACT,
        :decimal => VK_DECIMAL,
        :divide => VK_DIVIDE,

        :f1 => VK_F1,
        :f2 => VK_F2,
        :f3 => VK_F3,
        :f4 => VK_F4,
        :f5 => VK_F6,
        :f6 => VK_F6,
        :f7 => VK_F7,
        :f8 => VK_F8,
        :f9 => VK_F9,
        :f10 => VK_F10,
        :f11 => VK_F11,
        :f12 => VK_F12,
        :f13 => VK_F13,
        :f14 => VK_F14,
        :f15 => VK_F15,
        :f16 => VK_F16,
        :f17 => VK_F17,
        :f18 => VK_F18,
        :f19 => VK_F19,
        :f20 => VK_F20,
        :f21 => VK_F21,
        :f22 => VK_F22,
        :f23 => VK_F23,
        :f24 => VK_F24,

        :numlock => VK_NUMLOCK,
        :scroll => VK_SCROLL,
        :scrolllock => VK_SCROLL,

        :nec_equal => VK_OEM_NEC_EQUAL,

        :fujitsu_jisho => VK_OEM_FJ_JISHO,
        :fujitsu_masshou => VK_OEM_FJ_MASSHOU,
        :fujitsu_touroku => VK_OEM_FJ_TOUROKU,
        :fujitsu_loya => VK_OEM_FJ_LOYA,
        :fujitsu_roya => VK_OEM_FJ_ROYA,

        :lshift => VK_LSHIFT,
        :rshift => VK_RSHIFT,
        :lcontrol => VK_LCONTROL,
        :lctrl => VK_LCONTROL,
        :rcontrol => VK_RCONTROL,
        :rctrl => VK_RCONTROL,
        :lmenu => VK_LMENU,
        :lalt => VK_LALT,
        :rmenu => VK_RMENU,
        :ralt => VK_RALT,

        :browser_back => VK_BROWSER_BACK,
        :browser_forward => VK_BROWSER_FORWARD,
        :browser_refresh => VK_BROWSER_REFRESH,
        :browser_stop => VK_BROWSER_STOP,
        :browser_search => VK_BROWSER_SEARCH,
        :browser_favorites => VK_BROWSER_FAVORITES,
        :browser_home => VK_BROWSER_HOME,

        :volume_mute => VK_VOLUME_MUTE,
        :volume_down => VK_VOLUME_DOWN,
        :volume_up => VK_VOLUME_UP,
        :media_nexttrack => VK_MEDIA_NEXT_TRACK,
        :media_next=> VK_MEDIA_NEXT_TRACK,
        :media_prevtrack => VK_MEDIA_PREV_TRACK,
        :media_previous => VK_MEDIA_PREV_TRACK,
        :media_prev => VK_MEDIA_PREV_TRACK,
        :media_stop => VK_MEDIA_STOP,
        :media_playpause => VK_MEDIA_PLAY_PAUSE,
        :media_play => VK_MEDIA_PLAY_PAUSE,
        :media_pause => VK_MEDIA_PLAY_PAUSE,
        :launch_mail => VK_LAUNCH_MAIL,
        :launch_mediaselect => VK_LAUNCH_MEDIA_SELECT,
        :launch_media => VK_LAUNCH_MEDIA_SELECT,
        :launch_app1 => VK_LAUNCH_APP1,
        :launch_app2 => VK_LAUNCH_APP2,

        :oem_1 => VK_OEM_1,
        :oem_plus => VK_OEM_PLUS,
        :oem_comma => VK_OEM_COMMA,
        :oem_minus => VK_OEM_MINUS,
        :oem_period => VK_OEM_PERIOD,
        :oem_2 => VK_OEM_2,
        :oem_3 => VK_OEM_3,

        :oem_4 => VK_OEM_4,
        :oem_5 => VK_OEM_5,
        :oem_6 => VK_OEM_6,
        :oem_7 => VK_OEM_7,
        :oem_8 => VK_OEM_8,

        :oem_ax => VK_OEM_AX,
        :oem_102 => VK_OEM_102,
        :ico_help => VK_ICO_HELP,
        :ico_00 => VK_ICO_00,

        :processkey => VK_PROCESSKEY,
        :process => VK_PROCESSKEY,

        :ico_clear => VK_ICO_CLEAR,

        :packet => VK_PACKET,

        :oem_reset => VK_OEM_RESET,
        :oem_jump => VK_OEM_JUMP,
        :oem_pa1 => VK_OEM_PA1,
        :oem_pa2 => VK_OEM_PA2,
        :oem_pa3 => VK_OEM_PA3,
        :oem_wsctrl => VK_OEM_WSCTRL,
        :oem_cusel => VK_OEM_CUSEL,
        :oem_attn => VK_OEM_ATTN,
        :oem_finish => VK_OEM_FINISH,
        :oem_copy => VK_OEM_COPY,
        :oem_auto => VK_OEM_AUTO,
        :oem_enlw => VK_OEM_ENLW,
        :oem_backtab => VK_OEM_BACKTAB,

        :attn => VK_ATTN,
        :crsel => VK_CRSEL,
        :exsel => VK_EXSEL,
        :ereof => VK_EREOF,
        :vkplay => VK_PLAY,
        :zoom => VK_ZOOM,
        :noname => VK_NONAME,
        :pa1 => VK_PA1,
        :oem_clear => VK_OEM_CLEAR}
        
        #input constants
        
        INPUT_MOUSE = 0
        INPUT_KEYBOARD = 1
        INPUT_HARDWARE = 2
        
        KEYEVENTF_EXTENDEDKEY = 0x0001
        KEYEVENTF_KEYUP = 0x0002
        KEYEVENTF_UNICODE = 0x0004
        KEYEVENTF_SCANCODE = 0x0008
        
        #input structures
        
        class MOUSEINPUT < FFI::Struct
          layout :dx, LONG,
            :dy, LONG,
            :mouseData, DWORD,
            :dwFlags, DWORD,
            :time, DWORD,
            :dwExtraInfo, :pointer
        end
          
        class KEYBDINPUT < FFI::Struct
          layout :wVk, WORD,
            :wScan, WORD,
            :dwFlags, DWORD,
            :time, DWORD,
            :dwExtraInfo, :pointer
        end
          
        class HARDWAREINPUT < FFI::Struct
          layout :uMsg, DWORD,
            :wParamL, WORD,
            :wParamH, WORD
        end
        
        class INPUT_UNION < FFI::Union
          layout :mi, MOUSEINPUT,
            :ki, KEYBDINPUT,
            :hi, HARDWAREINPUT
        end
        
        class INPUT < FFI::Struct
          layout :type, DWORD,
            :union, INPUT_UNION
        end
        
        #monitor
        
        MONITORINFOF_PRIMARY = 0x00000001
        
        MONITOR_DEFAULTTONULL = 0x00000000
        MONITOR_DEFAULTTOPRIMARY = 0x00000001
        MONITOR_DEFAULTTONEAREST = 0x00000002
        
        #get/set window long field offsets
        
        GWL_WNDPROC = (-4)
        GWL_HINSTANCE = (-6)
        GWL_HWNDPARENT = (-8)
        GWL_STYLE = (-16)
        GWL_EXSTYLE = (-20)
        GWL_USERDATA = (-21)
        GWL_ID = (-12)
        
        #window styles
        
        WS_OVERLAPPED = 0x00000000
        WS_POPUP = 0x80000000
        WS_CHILD = 0x40000000
        WS_MINIMIZE = 0x20000000
        WS_VISIBLE = 0x10000000
        WS_DISABLED = 0x08000000
        WS_CLIPSIBLINGS = 0x04000000
        WS_CLIPCHILDREN = 0x02000000
        WS_MAXIMIZE = 0x01000000
        WS_BORDER = 0x00800000
        WS_DLGFRAME = 0x00400000
        WS_CAPTION = WS_BORDER | WS_DLGFRAME
        WS_VSCROLL = 0x00200000
        WS_HSCROLL = 0x00100000
        WS_SYSMENU = 0x00080000
        WS_THICKFRAME = 0x00040000
        WS_GROUP = 0x00020000
        WS_TABSTOP = 0x00010000

        WS_MINIMIZEBOX = 0x00020000
        WS_MAXIMIZEBOX = 0x00010000

        WS_TILED = WS_OVERLAPPED
        WS_ICONIC = WS_MINIMIZE
        WS_SIZEBOX = WS_THICKFRAME

        #common window styles

        WS_OVERLAPPEDWINDOW = WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX
        WS_TILEDWINDOW = WS_OVERLAPPEDWINDOW
        WS_POPUPWINDOW = WS_POPUP | WS_BORDER | WS_SYSMENU
        WS_CHILDWINDOW  = WS_CHILD
        
        #window style map
        
        WINDOW_STYLES = {:overlapped => WS_OVERLAPPED,
        :popup => WS_POPUP,
        :child => WS_CHILD,
        :minimize => WS_MINIMIZE,
        :visible => WS_VISIBLE,
        :disabled => WS_DISABLED,
        :clipsiblings => WS_CLIPSIBLINGS,
        :clipchildren => WS_CLIPCHILDREN,
        :maximize => WS_MAXIMIZE,
        :border => WS_BORDER,
        :dlgframe => WS_DLGFRAME,
        :caption => WS_CAPTION,
        :vscroll => WS_VSCROLL,
        :hscroll => WS_HSCROLL,
        :sysmenu => WS_SYSMENU,
        :thickframe => WS_THICKFRAME,
        :group => WS_GROUP,
        :tabstop => WS_TABSTOP,
        :minimizebox => WS_MINIMIZEBOX,
        :maximizebox => WS_MAXIMIZEBOX,}
        
        #extended window styles

        WS_EX_DLGMODALFRAME = 0x00000001
        WS_EX_NOPARENTNOTIFY = 0x00000004
        WS_EX_TOPMOST = 0x00000008
        WS_EX_ACCEPTFILES = 0x00000010
        WS_EX_TRANSPARENT = 0x00000020
        WS_EX_MDICHILD = 0x00000040
        WS_EX_TOOLWINDOW = 0x00000080
        WS_EX_WINDOWEDGE = 0x00000100
        WS_EX_CLIENTEDGE = 0x00000200
        WS_EX_CONTEXTHELP = 0x00000400
        WS_EX_RIGHT = 0x00001000
        WS_EX_LEFT = 0x00000000
        WS_EX_RTLREADING = 0x00002000
        WS_EX_LTRREADING = 0x00000000
        WS_EX_LEFTSCROLLBAR = 0x00004000
        WS_EX_RIGHTSCROLLBAR = 0x00000000
        WS_EX_CONTROLPARENT = 0x00010000
        WS_EX_STATICEDGE = 0x00020000
        WS_EX_APPWINDOW = 0x00040000
        WS_EX_OVERLAPPEDWINDOW = (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
        WS_EX_PALETTEWINDOW = (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)
        WS_EX_LAYERED = 0x00080000
        WS_EX_NOINHERITLAYOUT = 0x00100000 #disable inheritence of mirroring by children
        WS_EX_NOREDIRECTIONBITMAP = 0x00200000
        WS_EX_LAYOUTRTL = 0x00400000 #right to left mirroring
        WS_EX_COMPOSITED = 0x02000000
        WS_EX_NOACTIVATE = 0x08000000
        
        #extended window style map
        
        WINDOW_STYLES_EX = {:dlgmodalframe => WS_EX_DLGMODALFRAME,
          :noparentnotify => WS_EX_NOPARENTNOTIFY,
          :topmost => WS_EX_TOPMOST,
          :acceptfiles => WS_EX_ACCEPTFILES,
          :transparent => WS_EX_TRANSPARENT,
          :mdichild => WS_EX_MDICHILD,
          :toolwindow => WS_EX_TOOLWINDOW,
          :windowedge => WS_EX_WINDOWEDGE,
          :clientedge => WS_EX_CLIENTEDGE,
          :contexthelp => WS_EX_CONTEXTHELP,
          :right => WS_EX_RIGHT,
          :left => WS_EX_LEFT,
          :rtlreading => WS_EX_RTLREADING,
          :ltrreading => WS_EX_LTRREADING,
          :leftscrollbar => WS_EX_LEFTSCROLLBAR,
          :rightscrollbar => WS_EX_RIGHTSCROLLBAR,
          :controlparent => WS_EX_CONTROLPARENT,
          :staticedge => WS_EX_STATICEDGE,
          :appwindow => WS_EX_APPWINDOW,
          :layered => WS_EX_LAYERED,
          :noinheritlayout => WS_EX_NOINHERITLAYOUT,
          :noredirectionbitmap => WS_EX_NOREDIRECTIONBITMAP,
          :layoutrtl => WS_EX_LAYOUTRTL,
          :composited => WS_EX_COMPOSITED,
          :noactivate => WS_EX_NOACTIVATE}
      
        #window messages
        
        WM_NULL = 0x0000
        WM_CREATE = 0x0001
        WM_DESTROY = 0x0002
        WM_MOVE = 0x0003
        WM_SIZE = 0x0005

        WM_ACTIVATE = 0x0006

        #WM_ACTIVATE state values
        WA_INACTIVE = 0
        WA_ACTIVE = 1
        WA_CLICKACTIVE = 2

        WM_SETFOCUS = 0x0007
        WM_KILLFOCUS = 0x0008
        WM_ENABLE = 0x000A
        WM_SETREDRAW = 0x000B
        WM_SETTEXT = 0x000C
        WM_GETTEXT = 0x000D
        WM_GETTEXTLENGTH = 0x000E
        WM_PAINT = 0x000F
        WM_CLOSE = 0x0010
        WM_QUIT = 0x0012
        WM_ERASEBKGND = 0x0014
        WM_SYSCOLORCHANGE = 0x0015
        WM_SHOWWINDOW = 0x0018
        WM_WININICHANGE = 0x001A
        WM_SETTINGCHANGE = WM_WININICHANGE

        #windows ce window messages
        WM_QUERYENDSESSION = 0x0011
        WM_QUERYOPEN = 0x0013
        WM_ENDSESSION = 0x0016
        
        #window placement flags
        
        WPF_SETMINPOSITION = 0x0001
        WPF_RESTORETOMAXIMIZED = 0x0002
        WPF_ASYNCWINDOWPLACEMENT = 0x0004
        
        #message box
        
        MB_OK = 0x00000000
        MB_OKCANCEL = 0x00000001
        MB_ABORTRETRYIGNORE = 0x00000002
        MB_YESNOCANCEL = 0x00000003
        MB_YESNO = 0x00000004
        MB_RETRYCANCEL = 0x00000005
        MB_CANCELTRYCONTINUE = 0x00000006

        MB_ICONHAND = 0x00000010
        MB_ICONQUESTION = 0x00000020
        MB_ICONEXCLAMATION = 0x00000030
        MB_ICONASTERISK = 0x00000040
        MB_USERICON = 0x00000080
        MB_ICONWARNING = MB_ICONEXCLAMATION
        MB_ICONERROR = MB_ICONHAND
        MB_ICONINFORMATION = MB_ICONASTERISK
        MB_ICONSTOP = MB_ICONHAND

        MB_DEFBUTTON1 = 0x00000000
        MB_DEFBUTTON2 = 0x00000100
        MB_DEFBUTTON3 = 0x00000200
        MB_DEFBUTTON4 = 0x00000300

        MB_APPLMODAL = 0x00000000
        MB_SYSTEMMODAL = 0x00001000
        MB_TASKMODAL = 0x00002000
        MB_HELP = 0x00004000
        MB_NOFOCUS = 0x00008000
        MB_SETFOREGROUND = 0x00010000
        MB_DEFAULT_DESKTOP_ONLY = 0x00020000
        MB_TOPMOST = 0x00040000
        MB_RIGHT = 0x00080000
        MB_RTLREADING = 0x00100000
        MB_SERVICE_NOTIFICATION = 0x00200000
        
        #coordinate structures
        
        class POINT < FFI::Struct
  
          layout :x, LONG,
          :y, LONG
          
        end
        
        class RECT < FFI::Struct
  
          layout :left, LONG,
          :top, LONG,
          :right, LONG,
          :bottom, LONG
          
        end
        
        #monitor structures
        
        class MONITORINFO < FFI::Struct
  
          layout :cbSize, DWORD,
          :rcMonitor, RECT,
          :rcWork, RECT,
          :dwFlags, DWORD
          
        end
        
        class MONITORINFO < FFI::Struct
  
          layout :cbSize, DWORD,
          :rcMonitor, RECT,
          :rcWork, RECT,
          :dwFlags, DWORD,
          :szDevice, [WCHAR, CCHDEVICENAME]
          
        end
        
        #window structures
        
        class WINDOWPLACEMENT < FFI::Struct
  
          layout :length, UINT,
          :flags, UINT,
          :showCmd, DWORD,
          :ptMinPosition, POINT,
          :ptMaxPosition, POINT,
          :rcNormalPosition, RECT
          
        end
        
        #input
        
        attach_function :SendInput, [UINT, :pointer, :int], UINT
        
        attach_function :GetAsyncKeyState, [:int], SHORT
        attach_function :GetKeyboardState, [:buffer_out], BOOL
        attach_function :SetKeyboardState, [:buffer_in], BOOL
        
        
        #thread
        
        attach_function :PostThreadMessage, :PostThreadMessageW, [DWORD, UINT, WPARAM, LPARAM], BOOL
        
        #monitor
        attach_function :MonitorFromWindow, [HANDLE, DWORD], HANDLE
        attach_function :GetMonitorInfoW, [HANDLE, :pointer], BOOL
        
        def GetMonitorInfo(hMonitor, lpmi)
          lpmi[:cbSize] = lpmi.size
          return GetMonitorInfoW(hMonitor, lpmi)
        end
        
        #desktop
        
        attach_function :GetThreadDesktop, [DWORD], HANDLE
        
        #window
        
        attach_function :GetWindowLong, :GetWindowLongW, [HANDLE, :int], ULONG if FFI::Platform::ADDRESS_SIZE == 32
        attach_function :SetWindowLong, :SetWindowLongW, [HANDLE, :int, ULONG], ULONG if FFI::Platform::ADDRESS_SIZE == 32
        attach_function :GetWindowLong, :GetWindowLongPtrW, [HANDLE, :int], ULONG if FFI::Platform::ADDRESS_SIZE == 64
        attach_function :SetWindowLong, :SetWindowLongPtrW, [HANDLE, :int, ULONG], ULONG if FFI::Platform::ADDRESS_SIZE == 64
        attach_function :GetWindowPlacement, [HANDLE, :pointer], BOOL
        attach_function :SetWindowPlacement, [HANDLE, :pointer], BOOL
        
        attach_function :GetWindowText, :GetWindowTextW, [HANDLE, :buffer_out, :int], :int
        attach_function :SetWindowTextW, [HANDLE, :buffer_in], BOOL
        
        def SetWindowText(hWnd, lpString)
          return MessageBoxW(hWnd, lpString && lpString.encode("UTF-16LE"))
        end
        
        attach_function :GetWindowThreadProcessId, [HANDLE, :pointer], DWORD

        callback :WNDENUMPROC, [HANDLE, LPARAM], BOOL
        attach_function :EnumDesktopWindows, [HANDLE, :WNDENUMPROC, LPARAM], BOOL
        
        attach_function :MessageBoxW, [HANDLE, :buffer_in, :buffer_in, UINT], :int
        
        def MessageBox(hWnd, lpText, lpCaption, uType)
          return MessageBoxW(hWnd, lpText && lpText.encode("UTF-16LE"), lpCaption && lpCaption.encode("UTF-16LE"), uType)
        end
        
      end
    end
  end
end

