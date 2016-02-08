##
# Shared Makefile part for each POVRAY Project.
# All project makefiles can include this shared file for convenience.
# The including Makefile must only define the "PROJECT" variable, which defines
# the prefix for all project-related assets like .pov files, ini-files, images.
#
# (c) 2016 Alexander Schenkel
##

# Where is the povray binary?
POVRAY  ?= $(shell which povray)

# Define POVRAY ini sections which must be supported by the project:
VERSIONS := low thumb prev hd wqhd 4k


all: $(VERSIONS)

.PHONY: clean
clean:
	-rm *.png

### Project make target: Each Project must have 2 files:
### - PROJECT.pov: the scene file
### - PROJECT.ini: the config file, containing a section named after the version (e.g. '[low]')
$(VERSIONS): $(PROJECT).pov $(PROJECT).ini
	$(POVRAY) +o$(PROJECT)-$@.png +I$(PROJECT).pov $(PROJECT)[$@]
