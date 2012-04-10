Contributing to the TicketMonster tutorial
==========================================

Each section of the tutorial is contained in a `.txt` file in this git repository. To build the tutorial you'll need [AsciiDoc](http://www.methods.co.nz/asciidoc/index.html) installed. It's available via most major packaging systems (e.g. Debian, Fedora Extra, MacPorts), and has a Windows installer.

You'll also need pygments for syntax highlighting. It's available as a python egg.

Once you have installed AsciiDoc, you can build individual sections by invoking `asciidoc -b <output of choice> <section.txt>`. If you want to generate the whole tutorial as html, you can call `./generate.sh`.
