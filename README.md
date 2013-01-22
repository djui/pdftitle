# pdftitle

The commandline tool `pdftitle` is a Python implementation of the
[SciPlore Xtract: Extracting Titles from Scientific PDF documents](http://www.sciplore.org/publications/2010-splxtract-preprint.pdf)
paper, using mostly a structural layout analysis.

## Background

The title of a PDF article usually is in the filename but often is not. Next up
would be to check the title of the PDF metadata (using e.g. `pdfinfo`) but this
is also often not set or set incorrectly. Converting the PDF to text and picking
the first line often gives false positives or incomplete titles.

## Usage

    $ pdftitle
    Usage: pdftitle [options...] <file>
    
    Options:
     -h, --help        Show usage screen
     -v, --version     Show version info
     -m, --multi       Concatenate multiple title lines found (default)
     -s, --single      Only use first title line found
     -t, --top=<n>     Points from top to skip when searching for title (default: 80)
     -l, --length=<n>  Min title length to accept (default: 5)

## Dependencies

  * Python 2.7
  * [Poppler](http://poppler.freedesktop.org/) (pdftohtml)

## Accuracy

Using version 1.0.0, a sample set of 261 PDFs in Biology science result in:

  * **64.93**% (172) Success
    * 60.08% (160) Correct
    * 4.85% (12) Malformatted
  * **34.33**% (89) Failure
    * 8.58% (21) Incorrect
      * 4.10% (10) Incomplete
      * 4.48% (11) Wrong
    * 26.12% (68) Not found
      * 13.43% (35) Images
      * 12.69% (33) Unknown

![Success rate](https://docs.google.com/spreadsheet/oimg?key=0Aol4D_k5CpdrdFRKVGF1RWd3VDVZblN2M2VDb2tielE&oid=1&zx=i3jcp3wn5e26 "Success rate")
![Sucess](https://docs.google.com/spreadsheet/oimg?key=0Aol4D_k5CpdrdFRKVGF1RWd3VDVZblN2M2VDb2tielE&oid=6&zx=m476yiyjwu0x "Success")
![Failure](https://docs.google.com/spreadsheet/oimg?key=0Aol4D_k5CpdrdFRKVGF1RWd3VDVZblN2M2VDb2tielE&oid=2&zx=8n10onvlj1pt "Failure")
![Incorrect](https://docs.google.com/spreadsheet/oimg?key=0Aol4D_k5CpdrdFRKVGF1RWd3VDVZblN2M2VDb2tielE&oid=4&zx=3ihnchpnrb40 "Incorrect")
![Not found](https://docs.google.com/spreadsheet/oimg?key=0Aol4D_k5CpdrdFRKVGF1RWd3VDVZblN2M2VDb2tielE&oid=5&zx=rccbqtqetnky "Not found")

## License

`pdftitle` is licenced under a
[BSD License](https://github.com/djui/pdftitle/blob/master/LICENSE).
