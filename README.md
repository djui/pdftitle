# Introduction

The commandline tool `pdftitle` is a tiny Python implementation of the
[SciPlore Xtract: Extracting Titles from Scientific PDF documents](http://www.sciplore.org/publications/2010-splxtract-preprint.pdf)
paper.

# Background

The title of a PDF article usually is in the filename but often is not. Next up would be to check the title of the PDF metadata (using e.g. `pdfinfo`) but this is also often not set or set incorrectly. Converting the PDF to text and picking the first line often gives false positives or incomplete titles.

# Usage

    $ pdftitle
    Usage: pdftitle [options...] <file>
    
    Options:
     -h, --help        Show usage screen
     -v, --version     Show version info
     -m, --multi       Concatenate multiple title lines found (default)
     -s, --single      Only use first title line found
     -t, --top=<n>     Points from top to skip when searching for title (default: 80)
     -l, --length=<n>  Min title length to accept (default: 5)

# Dependencies

    $ brew install popper

# TODOs

  * Fix/Improve on 'Could not convert PDF to XML' errors
  * Fix/Improve on 'Could not parse XML' errors
  * Handle scanned PDFs
