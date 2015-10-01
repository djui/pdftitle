# pdftitle

The commandline tool `pdftitle` is a Python implementation of the
*SciPlore Xtract*[1] paper, using mostly a structural layout analysis.

By now, Docear has published the open-source tool
[PDF Inspector](https://github.com/Docear/PDF-Inspector) which does roughly the
same as this script. The differences are:

- Written in Java
- Uses ~~PDFBox~~ *jPod* instead of *pdftohtml*
- Simplier heuristics

> [1] *Joeran Beel, Bela Gipp, Ammar Shaker, and Nick Friedrich*.
> [SciPlore Xtract: Extracting Titles from Scientific PDF documents by Analyzing
> Style Information (Font Size)](http://docear.org/papers/SciPlore%20Xtract%20--%20Extracting%20Titles%20from%20Scientific%20PDF%20Documents%20by%20Analyzing%20Style%20Information%20%28Font%20Size%29-preprint.pdf).
> In M. Lalmas, J. Jose, A. Rauber, F. Sebastiani, and I. Frommholz, editors,
> Research and Advanced Technology for Digital Libraries, Proceedings of the
> 14th European Conference on Digital Libraries (ECDL-10), volume 6273 of
> Lecture Notes of Computer Science (LNCS), pages 413-416, Glasgow (UK),
> September 2010. Springer.

![Travis CI Status](https://travis-ci.org/djui/pdftitle.svg?branch=master)

## Background

The title of a PDF article usually is in the filename but often is not. Next up
would be to check the title of the PDF metadata (using e.g. `pdfinfo`) but this
is also often not set or set incorrectly. Converting the PDF to text and picking
the first line often gives false positives or incomplete titles.

## Usage

    $ pdftitle --help
    usage: pdftitle [-h] [-r] [-m] [-s] [-t TOP_MARGIN] [-n MIN_LENGTH] [-x MAX_LENGTH] [-d] [-v] FILE

    Tries to identify the title of PDF format paper.

    positional arguments:
      FILE                  Path to PDF file

    optional arguments:
      -h, --help            show this help message and exit
      -r, --rename          Rename file with found title
      -m, --multiline       Concatenate multiple title lines considered (default)
      -s, --singleline      Only use first title line considered
      -t TOP_MARGIN, --top-margin TOP_MARGIN
                            Top margin start to search for title (default: 70)
      -n MIN_LENGTH, --min-length MIN_LENGTH
                            Min. considerable title length (default: 15)
      -x MAX_LENGTH, --max-length MAX_LENGTH
                            Max. considerable title length (default: 250)
      -d, --debug           Print error stacktrace for unknown errors
      -v, --version         show program's version number and exit


## Dependencies

  * Python >=2.5
  * [Poppler](http://poppler.freedesktop.org/) >=0.20.5 (contains `pdftohtml`)

      `$ brew install poppler`

  * [lxml](http://lxml.de/) (optional, for higher accuracy)

      `$ pip install lxml`


## Accuracy

Version 1.0: A sample set of 261 PDFs in Biology science (which has many
scanned PDFs) results in 60.08% success rate.

Version 1.1: A sample set of 261 PDFs in Biology science (which has many
scanned PDFs) results in 76.25% success rate.

Version 1.2: No comparison available. (I lost the original sample set)

Version 1.3: No comparison available. (I lost the original sample set)


## Todos

**Version 2.0**: I will likely switch from Poppler/pdftohtml to PDFBox (or JPod)
to have no external dependencies. This will likely convert the script into a
Java CLI application. I was tinkering with a Go/Rust version (as bindings to
Poppler similar to [Go-Poppler](https://github.com/cheggaaa/go-poppler)) Let's
see.


## License

`pdftitle` is licenced under a
[BSD License](https://github.com/djui/pdftitle/blob/master/LICENSE).
