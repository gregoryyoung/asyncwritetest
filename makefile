#This make file has a src folder and a bin folder. To use edit the 
#variables at the top of the file.

#Project name will make project.exe project.dll etc
PROJECTNAME = asyncappend

#your src directory if you prefer Code/ for single folder use ./
SRCDIR = src/

#your bin directory if you prefer Whatever/ for single folder use ./
BINDIR = bin/

#libraries to add eg myfoo.dll,somethingelse.dll
LIBS = lib/EventStore.ClientAPI.dll,lib/Newtonsoft.Json.dll,lib/protobuf-net.dll

#type of output exe, winexe, library, module
OUTPUTTYPE=exe

#C# compiler
MCS=mcs

#any other compiler flags
GMCSFLAGS = -debug 

ifeq ($(OUTPUTTYPE),exe)
	GMCSFLAGS += /target:exe
	FULLOUTPUT = $(PROJECTNAME).exe
endif
ifeq ($(OUTPUTTYPE),library)
	GMCSFLAGS += /target:library
	FULLOUTPUT = $(PROJECTNAME).dll
endif
ifeq ($(OUTPUTTYPE),winexe)
	GMCSFLAGS += /target:winexe
	FULLOUTPUT = $(PROJECTNAME).exe
endif
ifeq ($(OUTPUTTYPE),module)
	GMCSFLAGS += /target:module
	FULLOUTPUT = $(PROJECTNAME).dll
endif


CSHARPFILES := $(shell find $(SRCDIR) -name '*.cs')
SRC = $(CSHARPFILES)
OUTPUT = $(BINDIR)$(FULLOUTPUT)


all: $(FULLOUTPUT)

$(FULLOUTPUT): $(SRC) outputdir 
	$(MCS) /out:$(OUTPUT) -r:$(LIBS) $(GMCSFLAGS) $(SRC)

outputdir:
	mkdir -p $(BINDIR)

#install: all
#       cp $(PROJECTNAME).dll /someplace	

clean:
	rm -f $(BINDIR)$(PROJECTNAME).exe
	rm -f $(BINDIR)$(PROJECTNAME).exe.mdb

