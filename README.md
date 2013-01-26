# pdftitle

The commandline tool `pdftitle` is a Python implementation of the
*SciPlore Xtract*[1] paper, using mostly a structural layout analysis.

> [1] *Joeran Beel, Bela Gipp, Ammar Shaker, and Nick Friedrich*.
> [SciPlore Xtract: Extracting Titles from Scientific PDF documents by Analyzing
> Style Information (Font Size)](http://docear.org/papers/SciPlore%20Xtract%20--%20Extracting%20Titles%20from%20Scientific%20PDF%20Documents%20by%20Analyzing%20Style%20Information%20%28Font%20Size%29-preprint.pdf).
> In M. Lalmas, J. Jose, A. Rauber, F. Sebastiani, and I. Frommholz, editors,
> Research and Advanced Technology for Digital Libraries, Proceedings of the
> 14th European Conference on Digital Libraries (ECDL-10), volume 6273 of
> Lecture Notes of Computer Science (LNCS), pages 413-416, Glasgow (UK),
> September 2010. Springer.

## Background

The title of a PDF article usually is in the filename but often is not. Next up
would be to check the title of the PDF metadata (using e.g. `pdfinfo`) but this
is also often not set or set incorrectly. Converting the PDF to text and picking
the first line often gives false positives or incomplete titles.

## Usage

    $ pdftitle
    Usage: pdftitle [options...] <file>
    
    Options:
     -t, --top=<n>     Points from top to skip when searching for title (default: 80)
     -l, --length=<n>  Min title length to accept (default: 5)
     -m, --multi       Concatenate multiple title lines found (default)
     -s, --single      Only use first title line found
     -v, --version     Show version info
     -h, --help        Show usage screen

## Dependencies

  * Python 2.5+
  * [Poppler](http://poppler.freedesktop.org/) (pdftohtml)
  * [lxml](http://lxml.de/) (optional)

## Accuracy

Using version 1.1, a sample set of 261 PDFs in Biology science (which has many
scanned PDFs) results in 76.25% success rate.

Using version 1.0, a sample set of 261 PDFs in Biology science (which has many
scanned PDFs) results in 60.08% success rate.

## License

`pdftitle` is licenced under a
[BSD License](https://github.com/djui/pdftitle/blob/master/LICENSE).
