var search_data = {"index":{"searchIndex":["dl","cfunc","cptr","dlerror","dltypeerror","handle","win32api","+()","+@()","-()","-@()","<=>()","==()","call()","[]()","[]()","[]()","[]()","[]()","[]=()","call()","call()","calltype()","calltype=()","close()","close_enabled?()","ctype()","ctype=()","disable_close()","dlopen()","dlunwrap()","dlwrap()","enable_close()","eql?()","free()","free()","free=()","inspect()","inspect()","last_error()","malloc()","malloc()","name()","new()","new()","new()","new()","null?()","ptr()","ptr()","ptr=()","realloc()","ref()","size()","size=()","sym()","sym()","to_i()","to_i()","to_i()","to_int()","to_ptr()","to_s()","to_s()","to_str()","to_value()","win32_last_error()"],"longSearchIndex":["dl","dl::cfunc","dl::cptr","dl::dlerror","dl::dltypeerror","dl::handle","win32api","dl::cptr#+()","dl::cptr#+@()","dl::cptr#-()","dl::cptr#-@()","dl::cptr#<=>()","dl::cptr#==()","win32api#call()","dl::cfunc#[]()","dl::cptr#[]()","dl::cptr::[]()","dl::handle#[]()","dl::handle::[]()","dl::cptr#[]=()","dl::cfunc#call()","win32api#call()","dl::cfunc#calltype()","dl::cfunc#calltype=()","dl::handle#close()","dl::handle#close_enabled?()","dl::cfunc#ctype()","dl::cfunc#ctype=()","dl::handle#disable_close()","dl::dlopen()","dl::dlunwrap()","dl::dlwrap()","dl::handle#enable_close()","dl::cptr#eql?()","dl::free()","dl::cptr#free()","dl::cptr#free=()","dl::cfunc#inspect()","dl::cptr#inspect()","dl::cfunc::last_error()","dl::malloc()","dl::cptr::malloc()","dl::cfunc#name()","dl::cfunc::new()","dl::cptr::new()","dl::handle::new()","win32api::new()","dl::cptr#null?()","dl::cfunc#ptr()","dl::cptr#ptr()","dl::cfunc#ptr=()","dl::realloc()","dl::cptr#ref()","dl::cptr#size()","dl::cptr#size=()","dl::handle::sym()","dl::handle#sym()","dl::cfunc#to_i()","dl::cptr#to_i()","dl::handle#to_i()","dl::cptr#to_int()","dl::cptr::to_ptr()","dl::cfunc#to_s()","dl::cptr#to_s()","dl::cptr#to_str()","dl::cptr#to_value()","dl::cfunc::win32_last_error()"],"info":[["DL","","classes/DL.html","",""],["DL::CFunc","","classes/DL/CFunc.html","",""],["DL::CPtr","","classes/DL/CPtr.html","",""],["DL::DLError","","classes/DL/DLError.html","",""],["DL::DLTypeError","","classes/DL/DLTypeError.html","",""],["DL::Handle","","classes/DL/Handle.html","",""],["Win32API","","classes/Win32API.html","",""],["+","DL::CPtr","classes/DL/CPtr.html#method-i-2B","(p1)","<p>Returns a new DL::CPtr that has been advanced <code>n</code> bytes.\n"],["+@","DL::CPtr","classes/DL/CPtr.html#method-i-2B-40","()","<p>Returns a DL::CPtr that is a dereferenced pointer for this DL::CPtr.\nAnalogous to the star operator in …\n"],["-","DL::CPtr","classes/DL/CPtr.html#method-i-2D","(p1)","<p>Returns a new DL::CPtr that has been moved back <code>n</code> bytes.\n"],["-@","DL::CPtr","classes/DL/CPtr.html#method-i-2D-40","()","<p>Returns a DL::CPtr that is a reference pointer for this DL::CPtr. Analogous\nto the ampersand operator …\n"],["<=>","DL::CPtr","classes/DL/CPtr.html#method-i-3C-3D-3E","(p1)","<p>Returns -1 if less than, 0 if equal to, 1 if greater than\n<code>other</code>.  Returns nil if <code>ptr</code> cannot be compared …\n"],["==","DL::CPtr","classes/DL/CPtr.html#method-i-3D-3D","(p1)","<p>Returns true if <code>other</code> wraps the same pointer, otherwise\nreturns false.\n"],["Call","Win32API","classes/Win32API.html#method-i-Call","(*args)",""],["[]","DL::CFunc","classes/DL/CFunc.html#method-i-5B-5D","(p1)","<p>Calls the function pointer passing in <code>ary</code> as values to the\nunderlying C function.  The return value depends …\n"],["[]","DL::CPtr","classes/DL/CPtr.html#method-i-5B-5D","(p1, p2 = v2)","<p>Returns integer stored at <em>index</em>.  If <em>start</em> and\n<em>length</em> are given, a string containing the bytes from  …\n"],["[]","DL::CPtr","classes/DL/CPtr.html#method-c-5B-5D","(p1)","<p>Get the underlying pointer for ruby object <code>val</code> and return it\nas a DL::CPtr object.\n"],["[]","DL::Handle","classes/DL/Handle.html#method-i-5B-5D","(p1)","<p>Get the address as an Integer for the function named <code>name</code>.\n"],["[]","DL::Handle","classes/DL/Handle.html#method-c-5B-5D","(p1)","<p>Get the address as an Integer for the function named <code>name</code>.\n"],["[]=","DL::CPtr","classes/DL/CPtr.html#method-i-5B-5D-3D","(p1, p2, p3 = v3)","<p>Set the value at <code>index</code> to <code>int</code>.  Or, set the\nmemory at <code>start</code> until <code>length</code> with the contents of\n<code>string</code> …\n"],["call","DL::CFunc","classes/DL/CFunc.html#method-i-call","(p1)","<p>Calls the function pointer passing in <code>ary</code> as values to the\nunderlying C function.  The return value depends …\n"],["call","Win32API","classes/Win32API.html#method-i-call","(*args)",""],["calltype","DL::CFunc","classes/DL/CFunc.html#method-i-calltype","()","<p>Get the call type of this function.\n"],["calltype=","DL::CFunc","classes/DL/CFunc.html#method-i-calltype-3D","(p1)","<p>Set the call type for this function.\n"],["close","DL::Handle","classes/DL/Handle.html#method-i-close","()","<p>Close this DL::Handle.  Calling close more than once will raise a\nDL::DLError exception.\n"],["close_enabled?","DL::Handle","classes/DL/Handle.html#method-i-close_enabled-3F","()","<p>Returns <code>true</code> if dlclose() will be called when this DL::Handle\nis garbage collected.\n"],["ctype","DL::CFunc","classes/DL/CFunc.html#method-i-ctype","()","<p>Get the C function return value type.  See DL for a list of constants\ncorresponding to this method’s …\n"],["ctype=","DL::CFunc","classes/DL/CFunc.html#method-i-ctype-3D","(p1)","<p>Set the C function return value type to <code>type</code>.\n"],["disable_close","DL::Handle","classes/DL/Handle.html#method-i-disable_close","()","<p>Disable a call to dlclose() when this DL::Handle is garbage collected.\n"],["dlopen","DL","classes/DL.html#method-c-dlopen","(*args)",""],["dlunwrap","DL","classes/DL.html#method-c-dlunwrap","(p1)",""],["dlwrap","DL","classes/DL.html#method-c-dlwrap","(p1)",""],["enable_close","DL::Handle","classes/DL/Handle.html#method-i-enable_close","()","<p>Enable a call to dlclose() when this DL::Handle is garbage collected.\n"],["eql?","DL::CPtr","classes/DL/CPtr.html#method-i-eql-3F","(p1)","<p>Returns true if <code>other</code> wraps the same pointer, otherwise\nreturns false.\n"],["free","DL","classes/DL.html#method-c-free","(p1)","<p>Free the memory at address <code>addr</code>\n"],["free","DL::CPtr","classes/DL/CPtr.html#method-i-free","()","<p>Get the free function for this pointer.  Returns  DL::CFunc or nil.\n"],["free=","DL::CPtr","classes/DL/CPtr.html#method-i-free-3D","(p1)","<p>Set the free function for this pointer to the DL::CFunc in\n<code>function</code>.\n"],["inspect","DL::CFunc","classes/DL/CFunc.html#method-i-inspect","()","<p>Returns a string formatted with an easily readable representation of the\ninternal state of the DL::CFunc …\n"],["inspect","DL::CPtr","classes/DL/CPtr.html#method-i-inspect","()","<p>Returns a string formatted with an easily readable representation of the\ninternal state of the DL::CPtr …\n"],["last_error","DL::CFunc","classes/DL/CFunc.html#method-c-last_error","()",""],["malloc","DL","classes/DL.html#method-c-malloc","(p1)","<p>Allocate <code>size</code> bytes of memory and return the integer memory\naddress for the allocated memory.\n"],["malloc","DL::CPtr","classes/DL/CPtr.html#method-c-malloc","(p1, p2 = v2)","<p>Allocate <code>size</code> bytes of memory and associate it with an\noptional <code>freefunc</code> that will be called when the …\n"],["name","DL::CFunc","classes/DL/CFunc.html#method-i-name","()","<p>Get the name of this function\n"],["new","DL::CFunc","classes/DL/CFunc.html#method-c-new","(p1, p2 = v2, p3 = v3, p4 = v4)","<p>Create a new function that points to <code>address</code> with an optional\nreturn type of <code>type</code>, a name of <code>name</code> and …\n"],["new","DL::CPtr","classes/DL/CPtr.html#method-c-new","(p1, p2 = v2, p3 = v3)","<p>Create a new pointer to <code>address</code> with an optional\n<code>size</code> and <code>freefunc</code>. <code>freefunc</code> will be\ncalled when the …\n"],["new","DL::Handle","classes/DL/Handle.html#method-c-new","(p1 = v1, p2 = v2)","<p>Create a new handler that opens library named <code>lib</code> with\n<code>flags</code>.  If no library is specified, RTLD_DEFAULT …\n"],["new","Win32API","classes/Win32API.html#method-c-new","(dllname, func, import, export = \"0\", calltype = :stdcall)",""],["null?","DL::CPtr","classes/DL/CPtr.html#method-i-null-3F","()","<p>Returns true if this is a null pointer.\n"],["ptr","DL::CFunc","classes/DL/CFunc.html#method-i-ptr","()","<p>Get the underlying function pointer as a DL::CPtr object.\n"],["ptr","DL::CPtr","classes/DL/CPtr.html#method-i-ptr","()","<p>Returns a DL::CPtr that is a dereferenced pointer for this DL::CPtr.\nAnalogous to the star operator in …\n"],["ptr=","DL::CFunc","classes/DL/CFunc.html#method-i-ptr-3D","(p1)","<p>Set the underlying function pointer to a DL::CPtr named\n<code>pointer</code>.\n"],["realloc","DL","classes/DL.html#method-c-realloc","(p1, p2)","<p>Change the size of the memory allocated at the memory location\n<code>addr</code> to <code>size</code> bytes.  Returns the memory …\n"],["ref","DL::CPtr","classes/DL/CPtr.html#method-i-ref","()","<p>Returns a DL::CPtr that is a reference pointer for this DL::CPtr. Analogous\nto the ampersand operator …\n"],["size","DL::CPtr","classes/DL/CPtr.html#method-i-size","()","<p>Get the size of this pointer.\n"],["size=","DL::CPtr","classes/DL/CPtr.html#method-i-size-3D","(p1)","<p>Set the size of this pointer to <code>size</code>\n"],["sym","DL::Handle","classes/DL/Handle.html#method-c-sym","(p1)","\n<pre>Document-method: []</pre>\n<p>Get the address as an Integer for the function named <code>name</code>.\n"],["sym","DL::Handle","classes/DL/Handle.html#method-i-sym","(p1)","\n<pre>Document-method: []</pre>\n<p>Get the address as an Integer for the function named <code>name</code>.\n"],["to_i","DL::CFunc","classes/DL/CFunc.html#method-i-to_i","()","<p>Returns the memory location of this function pointer as an integer.\n"],["to_i","DL::CPtr","classes/DL/CPtr.html#method-i-to_i","()","<p>Returns the integer memory location of this DL::CPtr.\n"],["to_i","DL::Handle","classes/DL/Handle.html#method-i-to_i","()","<p>Returns the memory address for this handle.\n"],["to_int","DL::CPtr","classes/DL/CPtr.html#method-i-to_int","()","<p>Returns the integer memory location of this DL::CPtr.\n"],["to_ptr","DL::CPtr","classes/DL/CPtr.html#method-c-to_ptr","(p1)","<p>Get the underlying pointer for ruby object <code>val</code> and return it\nas a DL::CPtr object.\n"],["to_s","DL::CFunc","classes/DL/CFunc.html#method-i-to_s","()","<p>Returns a string formatted with an easily readable representation of the\ninternal state of the DL::CFunc …\n"],["to_s","DL::CPtr","classes/DL/CPtr.html#method-i-to_s","(p1 = v1)","<p>Returns the pointer contents as a string.  When called with no arguments,\nthis method will return the …\n"],["to_str","DL::CPtr","classes/DL/CPtr.html#method-i-to_str","(p1 = v1)","<p>Returns the pointer contents as a string.  When called with no arguments,\nthis method will return the …\n"],["to_value","DL::CPtr","classes/DL/CPtr.html#method-i-to_value","()","<p>Cast this CPtr to a ruby object.\n"],["win32_last_error","DL::CFunc","classes/DL/CFunc.html#method-c-win32_last_error","()",""]]}}