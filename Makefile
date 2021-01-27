SRCS 		:= $(shell find . -depth 2 -type f -name "*.md" ! -name README.md)

PDFOBJS		= $(SRCS:.md=.pdf)
HTMLOBJS	= $(SRCS:.md=.html)
PANDOC		= pandoc
PDFFLAGS    = -V geometry:"top=1cm, bottom=1cm, left=1.5cm, right=1.5cm" #--template recipes.latex
HTMLFLAGS   = --from markdown --template recipes.html5 --listings

.PHONY: all clean html pdf 

all: clean $(HTMLOBJS) $(PDFOBJS)
	@echo HTML and PDF generated

%.pdf:	%.md
	$(PANDOC) $(PDFFLAGS) $< -o $@

pdf: cleanpdf $(PDFOBJS)

%.html: %.md
	pandoc $(HTMLFLAGS) $< -o $@

html: $(HTMLOBJS)

clean: cleanpdf cleanhtml

cleanpdf:
	@rm -f $(PDFOBJS)

cleanhtml:
	@rm -f $(HTMLOBJS) 
