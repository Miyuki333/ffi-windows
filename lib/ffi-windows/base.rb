require "ffi"

module FFI

  class Struct
    
    def self.struct_reader(dest, source)
      source ||= dest
      define_method(dest) do
        self[source]
      end
    end
    
    def self.struct_writer(dest, source)
      source ||= dest
      define_method(dest.to_s + "=") do | object |
        self[source] = object
      end
    end
    
    def self.struct_accessor(dest, source)
      struct_reader(dest, source)
      struct_writer(dest, source)
    end
    
    def dup
      return self.class.new(self.to_ptr.dup)
    end

  end
  
  class Pointer
    
    WIDESTRING_NULL = "\0\0".force_encoding("UTF-16LE")
    
    def to_ws
      string = self.read_bytes(self.size).force_encoding("UTF-16LE")
      i = string.index(WIDESTRING_NULL)
      i == nil ? "" : string[0...i]
    end
    
  end
  
  module Windows
  
    FALSE = 0
    TRUE = 1
  
    BOOL = :int
    BYTE = :uchar
    WORD = :ushort
    DWORD = :ulong
    FLOAT = :float
    
    CHAR = :char
    UCHAR = :uchar
    WCHAR = :ushort
    SHORT = :short
    USHORT = :ushort
    INT = :int
    UINT = :uint
    LONG = :long
    ULONG = :ulong
    LONG_PTR = :long_long
    SIZE_T = :size_t
    
    HANDLE = :pointer
    WPARAM = :pointer
    LPARAM = :pointer
    LRESULT = :pointer
    
  end
  
end
