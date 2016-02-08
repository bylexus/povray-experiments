THUMBSDIR = thumbs
SCENESDIR = scenes
PROJECTMAKES = $(wildcard $(SCENESDIR)/*/Makefile)
PROJECTS  = $(patsubst $(SCENESDIR)/%/Makefile,%,$(PROJECTMAKES))
THUMBS    = $(patsubst %,$(THUMBSDIR)/%-thumb.png,$(PROJECTS))

### Make missing thumbs from projects
thumbs: $(THUMBS)
	
### Creates a specific thumb image
$(THUMBS):
	mkdir -p $(THUMBSDIR); \
	PROJECT=$(patsubst $(THUMBSDIR)/%-thumb.png,%,$@); \
	PROJECTDIR=$(SCENESDIR)/$${PROJECT}/ ; \
	CWD=$(shell pwd); \
	cd $$PROJECTDIR && make thumb && cd $$CWD; \
	cp $$PROJECTDIR/$$PROJECT-thumb.png $(THUMBSDIR)/
