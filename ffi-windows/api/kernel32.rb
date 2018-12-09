require "ffi"
require "ffi-windows/base"

module FFI
  module Windows
    module API
      module Kernel32

        extend FFI::Library

        ffi_lib "kernel32"
        ffi_convention :stdcall

        #constants
        MAX_PATH = 0x104
    
        INFINITE = 0xFFFFFFFF
        STILL_ACTIVE = 0x103
        
        #access rights
    
        DELETE = 0x00010000
        READ_CONTROL = 0x00020000
        WRITE_DAC = 0x00040000
        WRITE_OWNER = 0x00080000
        SYNCHRONIZE = 0x00100000

        STANDARD_RIGHTS_REQUIRED = 0x000F0000

        STANDARD_RIGHTS_READ = READ_CONTROL
        STANDARD_RIGHTS_WRITE = READ_CONTROL
        STANDARD_RIGHTS_EXECUTE = READ_CONTROL

        STANDARD_RIGHTS_ALL = 0x001F0000

        SPECIFIC_RIGHTS_ALL = 0x0000FFFF

        ACCESS_SYSTEM_SECURITY = 0x01000000

        MAXIMUM_ALLOWED = 0x02000000

        GENERIC_READ = 0x80000000
        GENERIC_WRITE = 0x40000000
        GENERIC_EXECUTE = 0x20000000
        GENERIC_ALL = 0x10000000
        
        #thread access rights
        
        THREAD_TERMINATE = 0x0001
        THREAD_SUSPEND_RESUME = 0x0002
        THREAD_GET_CONTEXT = 0x0008
        THREAD_SET_CONTEXT = 0x0010
        THREAD_QUERY_INFORMATION = 0x0040
        THREAD_SET_INFORMATION = 0x0020
        THREAD_SET_THREAD_TOKEN = 0x0080
        THREAD_IMPERSONATE = 0x0100
        THREAD_DIRECT_IMPERSONATION = 0x0200
        THREAD_SET_LIMITED_INFORMATION = 0x0400
        THREAD_QUERY_LIMITED_INFORMATION = 0x0800
        THREAD_RESUME = 0x1000
        THREAD_ALL_ACCESS = STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0xFFFF
      
        #process
        
        PROCESS_NAME_NATIVE = 0x00000001
      
        #process access rights
        
        PROCESS_TERMINATE = 0x0001
        PROCESS_CREATE_THREAD = 0x0002
        PROCESS_VM_OPERATION = 0x0008
        PROCESS_VM_READ = 0x0010
        PROCESS_VM_WRITE = 0x0020
        PROCESS_DUP_HANDLE = 0x0040
        PROCESS_CREATE_PROCESS = 0x0080
        PROCESS_SET_QUOTA = 0x0100
        PROCESS_SET_INFORMATION = 0x0200
        PROCESS_QUERY_INFORMATION = 0x0400
        PROCESS_SUSPEND_RESUME = 0x0800
        PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
        PROCESS_ALL_ACCESS = STANDARD_RIGHTS_REQUIRED | SYNCHRONIZE | 0xFFFF
        
        #process creation flags
        
        DEBUG_PROCESS = 0x00000001
        DEBUG_ONLY_THIS_PROCESS = 0x00000002
        CREATE_SUSPENDED = 0x00000004
        DETACHED_PROCESS = 0x00000008
        CREATE_NEW_CONSOLE = 0x00000010
        
        NORMAL_PRIORITY_CLASS = 0x00000020
        IDLE_PRIORITY_CLASS = 0x00000040
        HIGH_PRIORITY_CLASS = 0x00000080
        REALTIME_PRIORITY_CLASS = 0x00000100
        
        CREATE_NEW_PROCESS_GROUP = 0x00000200
        CREATE_UNICODE_ENVIRONMENT = 0x00000400
        CREATE_SEPARATE_WOW_VDM = 0x00000800
        CREATE_SHARED_WOW_VDM = 0x00001000
        CREATE_FORCEDOS = 0x00002000
        
        BELOW_NORMAL_PRIORITY_CLASS = 0x00004000
        ABOVE_NORMAL_PRIORITY_CLASS = 0x00008000

        INHERIT_PARENT_AFFINITY = 0x00010000
        INHERIT_CALLER_PRIORITY = 0x00020000 #deprecated
        CREATE_PROTECTED_PROCESS = 0x00040000
        EXTENDED_STARTUPINFO_PRESENT = 0x00080000

        PROCESS_MODE_BACKGROUND_BEGIN = 0x00100000
        PROCESS_MODE_BACKGROUND_END = 0x00200000

        CREATE_BREAKAWAY_FROM_JOB = 0x01000000
        CREATE_PRESERVE_CODE_AUTHZ_LEVEL = 0x02000000
        CREATE_DEFAULT_ERROR_MODE = 0x04000000
        CREATE_NO_WINDOW = 0x08000000

        PROFILE_USER = 0x10000000
        PROFILE_KERNEL = 0x20000000
        PROFILE_SERVER = 0x40000000
        CREATE_IGNORE_SYSTEM_DEFAULT = 0x80000000
        
        #toolhelp32
        
        TH32CS_INHERIT = 0x80000000
        TH32CS_SNAPHEAPLIST = 0x00000001
        TH32CS_SNAPPROCESS = 0x00000002
        TH32CS_SNAPTHREAD = 0x00000004
        TH32CS_SNAPMODULE = 0x00000008
        TH32CS_SNAPMODULE32 = 0x00000010
        
        TH32CS_SNAPALL = TH32CS_SNAPHEAPLIST | TH32CS_SNAPMODULE | TH32CS_SNAPPROCESS | TH32CS_SNAPTHREAD
        
        #wait
        
        WAIT_OBJECT_0 = 0x00000000
        WAIT_ABANDONED = 0x00000080
        WAIT_TIMEOUT = 0x00000102
        WAIT_FAILED = 0xFFFFFFFF
        
        #error
        
        attach_function :GetLastError, [], DWORD
        
        #memory
        
        attach_function :RtlMoveMemory, [:pointer, :pointer, SIZE_T], :void
      
        #handle
        
        attach_function :CloseHandle, [HANDLE], BOOL
        
        #thread
        
        attach_function :GetCurrentThreadId, [], DWORD
        attach_function :OpenThread, [DWORD, BOOL, DWORD], HANDLE
        attach_function :WaitForSingleObject, [HANDLE, DWORD], DWORD

        #process
        
        attach_function :CreateProcessW, [:buffer_in, :buffer_in, :pointer, :pointer, BOOL, DWORD, :pointer, :buffer_in, :pointer, :pointer], BOOL
        attach_function :GetProcessId, [HANDLE], DWORD
        attach_function :OpenProcess, [DWORD, BOOL, DWORD], HANDLE
        attach_function :QueryFullProcessImageNameW, [HANDLE, DWORD, :buffer_in, :pointer], BOOL
        attach_function :TerminateProcess, [HANDLE, UINT], BOOL
        attach_function :GetExitCodeProcess, [HANDLE, :pointer], BOOL
        
        def CreateProcess(lpApplicationName, lpCommandLine, lpProcessAttributes, lpThreadAttributes, bInheritHandles, dwCreationFlags, lpEnvironment, lpCurrentDirectory, lpStartupInfo, lpProcessInformation)
          CreateProcessW(lpApplicationName && lpApplicationName.encode("UTF-16LE"), lpCommandLine && lpCommandLine.encode("UTF-16LE"), lpProcessAttributes, lpThreadAttributes, bInheritHandles, dwCreationFlags, lpEnvironment, lpCurrentDirectory && lpCurrentDirectory.encode("UTF-16LE"), lpStartupInfo, lpProcessInformation)
        end
        
        module_function :CreateProcess
        
        def QueryFullProcessImageName(hProcess, dwFlags, lpExeName, lpdwSize)
          return QueryFullProcessImageNameW(hProcess, dwFlags, lpExeName && lpExeName.encode("UTF-16LE"), lpdwSize)
        end
  
        module_function :QueryFullProcessImageName
      
        class PROCESS_INFORMATION < FFI::Struct
  
          layout :hProcess, HANDLE,
          :hThread, HANDLE,
          :dwProcessId, DWORD,
          :dwThreadId, DWORD
          
          struct_accessor :process, :hProcess
          struct_accessor :thread, :hThread
          struct_accessor :pid, :dwProcessId
          struct_accessor :tid, :dwThreadId
          
        end
        
        class STARTUPINFO < FFI::Struct
  
          layout :cb, DWORD,
          :lpReserved, :pointer,
          :lpTitle, :pointer,
          :dwX, DWORD,
          :dwY, DWORD,
          :dwXSize, DWORD,
          :dwYSize, DWORD,
          :dwXCountChars, DWORD,
          :dwYCountChars, DWORD,
          :dwFillAttribute, DWORD,
          :dwFlags, DWORD,
          :wShowWindow, WORD,
          :cbReserved2, WORD,
          :lpReserved2, :pointer,
          :hStdInput, HANDLE,
          :hStdOutput, HANDLE,
          :hStdError, HANDLE
          
        end
        
        class SECURITY_ATTRIBUTES < FFI::Struct
  
          layout :nLength, DWORD,
          :lpSecurityDescriptor, :pointer,
          :bInheritHandle, BOOL
          
        end
        
        #Toolhelp32
        
        attach_function :CreateToolhelp32Snapshot, [DWORD, DWORD], HANDLE
        attach_function :Thread32FirstO, :Thread32First, [HANDLE, :pointer], BOOL
        attach_function :Thread32NextO, :Thread32Next, [HANDLE, :pointer], BOOL
        attach_function :Process32FirstW, [HANDLE, :pointer], BOOL
        attach_function :Process32NextW, [HANDLE, :pointer], BOOL
        
        def Thread32First(hSnapshot, lpte)
          lpte[:dwSize] = lpte.size
          return Thread32FirstO(hSnapshot, lpte)
        end
        
        module_function :Thread32First
        
        def Thread32First(hSnapshot, lpte)
          lpte[:dwSize] = lpte.size
          return Thread32FirstO(hSnapshot, lpte)
        end
        
        module_function :Thread32First
        
        def Process32First(hSnapshot, lppe)
          lppe[:dwSize] = lppe.size
          return Process32FirstW(hSnapshot, lppe)
        end
        
        module_function :Process32First
        
        def Process32Next(hSnapshot, lppe)
          lppe[:dwSize] = lppe.size
          return Process32NextW(hSnapshot, lppe)
        end
        
        module_function :Process32Next
        
        class THREADENTRY32 < FFI::Struct
          
          layout :dwSize, DWORD,
          :cntUsage, DWORD,
          :th32ThreadID, DWORD,
          :th32OwnerProcessID, DWORD,
          :tpBasePri, LONG,
          :tpDeltaPri, LONG,
          :dwFlags, DWORD
          
          struct_accessor :usage, :cntUsage
          struct_accessor :tid, :th32ThreadID
          struct_accessor :owner_pid, :th32OwnerProcessID
          struct_accessor :base_priority, :tpBasePri
          struct_accessor :delta, :tpDeltaPri
          struct_accessor :flags, :dwFlags
          
        end
        
        
        class PROCESSENTRY32 < FFI::Struct
          
          layout :dwSize, DWORD,
          :cntUsage, DWORD,
          :th32ProcessID, DWORD,
          :th32DefaultHeapID, :pointer,
          :th32ModuleID, DWORD,
          :cntThread, DWORD,
          :th32ParentProcessID, DWORD,
          :pcPriClassBase, LONG,
          :dwFlags, DWORD,
          :szExeFile, [WCHAR, MAX_PATH]
          
          struct_accessor :usage, :cntUsage
          struct_accessor :pid, :th32ProcessID
          struct_accessor :default_heap, :th32DefaultHeapID
          struct_accessor :module_id, :th32ModuleID
          struct_accessor :threads, :cntThread
          struct_accessor :parent_pid, :th32ParentProcessID
          struct_accessor :base_priority, :pcPriClassBase
          struct_accessor :flags, :dwFlags
          
          def name
            return self[:szExeFile].to_ptr.to_ws.encode("utf-8")
          end
          
        end
      
      end
    end
  end
end