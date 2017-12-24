# NMakefile
# https://msdn.microsoft.com/en-us/library/x6bt6xe7.aspx

INC_TARGET = $(VCINSTALLDIR)include

all: testopt.exe
  
.c.obj: 
  cl -nologo -I. -Zi -Od -DDEBUG -c -GS -DWIN32 -W3 -D_MT -MTd testopt.c $*.c

testopt.exe: testopt.obj
  link /DEBUG  /INCREMENTAL:NO /NOLOGO -subsystem:console -out:testopt.exe testopt.obj

check: all
  @echo.
  testopt
  testopt -a -b
  testopt -ab
  testopt -c foo
  testopt -cfoo
  testopt arg1
  testopt -a arg1
  testopt -c foo arg1
  testopt -a -- -b
  testopt -a -
  @echo.

install: check
  @echo "Installing getopt.h to $(INC_TARGET)"
  @copy getopt.h "$(INC_TARGET)"

clean:
  @del *.obj

realclean:
  @del *.obj *.exe *.exp *.pdb *.idb *.ilk
