%module archive

%include "stdint.i"
%include "typemaps.i"

%{
	#include "wrapper.h"
%}

%newobject Archive::read_next_header;

%include "wrapper.h"
