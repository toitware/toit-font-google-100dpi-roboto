# Roboto

Roboto sans-serif fonts for Toit devices.

This is a scalable sans-serif font used on Android phones among other places.

The bitmap versions here have been automatically generated, and
can be a little rough around the edges, especially on low resolution
displays.  They are available in larger sizes than the hand-optimized
bitmap fonts.  The upstream source is
git://github.com/googlefonts/roboto.git and can be fetched with
`git submodule update --init --recursive`.

The styles are thin, light, regular, medium, bold, and black.
Each style is also available in an italic variant.  Sizes are 10,
11, 12, 14, 16, 18, 20, 22, 24, 28, 32, and 36.

Roboto has good coverage of Roman, Greek, and Cyrillic alphabets.

## Usage

``` toit
import font show *
import roboto.regular_14 as roboto_14
import roboto.regular_italic_14 as roboto_14i

MY_FONT ::= Font [roboto_14.ASCII, roboto_14.CURRENCY_SYMBOLS]
MY_ITALICS ::= Font [roboto_14i.ASCII]
```
