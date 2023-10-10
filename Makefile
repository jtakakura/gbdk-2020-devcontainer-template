PROJECT_NAME=rom

LCC = lcc
CFLAGS += -Wa-n -msm83:gb --no-std-crt0 --fsigned-char --use-stdout -Dnonbanked= -I$(GBDK_PATH)/include -D__PORT_sm83 -D__TARGET_gb -I$(GBDK_PATH)/include/asm  -DFILE_NAME=$(basename $(<F)) -MMD

SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(shell find $(SRCDIR) -name '*.c')
OBJECTS  := $(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SOURCES))

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

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@echo Compiling
	@mkdir -p $(@D)
	@$(LCC) $(LFLAGS) $(CFLAGS) -c -o $@ $<	

$(BINDIR)/$(PROJECT_NAME).$(EXTENSION): $(BINDIR) $(OBJECTS)
	@echo Linking
	@$(LCC) $(LFLAGS) -Wa-l -Wl-m -Wl-j -o $(BINDIR)/$(PROJECT_NAME).$(EXTENSION) $(OBJECTS)


.PHONY: clean release debug color
.DEFAULT_GOAL := all

clean:
	@echo Cleaning
	@rm -rf $(BINDIR) $(OBJDIR)

release: CFLAGS += -DNDEBUG
release: $(BINDIR)/$(PROJECT_NAME).$(EXTENSION)

debug: CFLAGS += -debug
debug: LFLAGS += -y
debug: PROJECT_NAME := $(PROJECT_NAME)-debug
debug: $(BINDIR)/$(PROJECT_NAME).$(EXTENSION)

all: release
