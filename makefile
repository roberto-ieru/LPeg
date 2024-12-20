LIBNAME = lpeg
LUADIR = ./lua/
#LUADIR = /home/roberto/prj/lua/

COPT = -O2 -DNDEBUG
# COPT = -O0 -DLPEG_DEBUG -g

CWARNS = -Wall -Wextra -pedantic \
	-Waggregate-return \
	-Wcast-align \
	-Wcast-qual \
	-Wdisabled-optimization \
	-Wpointer-arith \
	-Wshadow \
	-Wredundant-decls \
	-Wsign-compare \
	-Wundef \
	-Wwrite-strings \
	-Wbad-function-cast \
	-Wdeclaration-after-statement \
	-Wmissing-prototypes \
	-Wmissing-declarations \
	-Wnested-externs \
	-Wstrict-prototypes \
	-Wc++-compat \
# -Wunreachable-code \


CFLAGS = $(CWARNS) $(COPT) -std=c99 -I$(LUADIR) -fPIC
CC = gcc

FILES = lpvm.o lpcap.o lptree.o lpcode.o lpprint.o lpcset.o

# For Linux
linux:
	$(MAKE) lpeg.so "DLLFLAGS = -shared -fPIC"

# For Mac OS
macosx:
	$(MAKE) lpeg.so "DLLFLAGS = -bundle -undefined dynamic_lookup"

lpeg.so: $(FILES)
	env $(CC) $(DLLFLAGS) $(FILES) -o lpeg.so

$(FILES): makefile

test: test.lua re.lua lpeg.so
	./test.lua

clean:
	rm -f $(FILES) lpeg.so


lpcap.o: lpcap.c lpcap.h lptypes.h
lpcode.o: lpcode.c lptypes.h lpcode.h lptree.h lpvm.h lpcap.h lpcset.h
lpcset.o: lpcset.c lptypes.h lpcset.h lpcode.h lptree.h lpvm.h lpcap.h
lpprint.o: lpprint.c lptypes.h lpprint.h lptree.h lpvm.h lpcap.h lpcode.h
lptree.o: lptree.c lptypes.h lpcap.h lpcode.h lptree.h lpvm.h lpprint.h \
 lpcset.h
lpvm.o: lpvm.c lpcap.h lptypes.h lpvm.h lpprint.h lptree.h
