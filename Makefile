PROJECT_NAME=hello

LCC = lcc
CFLAGS += -Wa-n -mgbz80:gb --no-std-crt0 --fsigned-char --use-stdout -Dnonbanked= -I$(GBDK_PATH)/include -D__PORT_gbz80 -D__TARGET_gb -I$(GBDK_PATH)/include/asm  -DFILE_NAME=$(basename $(<F)) -MMD

SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

# DMG/Color flags
EXTENSION = gb
ifneq (,$(findstring color,$(MAKECMDGOALS)))
	BINFLAGS += -yc
	CFLAGS += -DCGB
	EXTENSION = gbc
endif

$(BINDIR):
	@echo Creating directory $(BINDIR)
	@mkdir $(BINDIR)

$(OBJDIR):
	@echo Creating directory $(OBJDIR)
	@mkdir $(OBJDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo Compiling $<
	@$(LCC) $(CFLAGS) -c -o $@ $<	

$(BINDIR)/$(PROJECT_NAME).$(EXTENSION): $(BINDIR) $(OBJDIR) $(OBJECTS)
	@echo Linking
	@$(LCC) -Wm-yc -o $(BINDIR)/$(PROJECT_NAME).$(EXTENSION) $(OBJECTS)


.PHONY: clean release debug color
.DEFAULT_GOAL := all

clean:
	@echo Cleaning
	@rm -rf $(BINDIR)
	@rm  -f $(OBJDIR)/*.*

release: CFLAGS += -DNDEBUG
release: $(BINDIR)/$(PROJECT_NAME).$(EXTENSION)

debug: CFLAGS += --debug
debug: LFLAGS += -y
debug: PROJECT_NAME := $(PROJECT_NAME)-debug
debug: $(BINDIR)/$(PROJECT_NAME).$(EXTENSION)

all: release
