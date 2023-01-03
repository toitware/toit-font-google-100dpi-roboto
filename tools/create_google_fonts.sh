#!/bin/sh

# Copyright (C) 2020 Toitware ApS. All rights reserved.

# Produce verbose or terse .toit files.
VERBOSE=
#VERBOSE=--verbose

set -e

TMP=tools/tmp
touch tools/create_google_fonts.sh  # Should be run from top level directory.
mkdir -p $TMP
rm -rf $TMP/*

# The toit-font-google-100dpi-roboto repo should be checked out
# in the toit repo.
DIR_PKG=.
DIR_ROBOTO=$DIR_PKG/third_party/roboto
OUT_100DPI=$DIR_PKG/src/
TOITC="jag run -d host"
CONVERT="../../toitlang/toit-font-tools/app/convertfont.toit $VERBOSE"
FONT_FORGE=tools/convert.fontforge

mkdir -p $OUT_100DPI

# TODO(3279): For larger sizes we need to fix the issue that limits font files
# to 4k.
# Smaller sizes than 10 are too ugly in automatically rasterized fonts.
# Larger sizes than 36 create too large font files, currently.
for size in 10 11 12 14 16 18 20 22 24 28 32 36 40 44 48 56 64
do
  for weight in BlackItalic Black BoldItalic Bold MediumItalic Medium Italic Regular LightItalic Light ThinItalic Thin
  do
    lower_case=`echo $weight | sed 's/\([IBMRLT]\)/_\1/g' | tr A-Z a-z | sed 's/_//'`
    $FONT_FORGE $DIR_ROBOTO/src/hinted/Roboto-$weight.ttf $size $TMP/roboto-$lower_case.bdf
    $TOITC $CONVERT $TMP/roboto-$lower_case-$size.bdf "Roboto $weight" $OUT_100DPI/${lower_case}_$size.toit &
  done
done
wait  # Wait for backgrounded jobs.
cp $DIR_ROBOTO/LICENSE $DIR_PKG

# Fontforge makes a mess of the 'r' in Roboto-Regular size 10, so substitute
# Medium for Regular, which is almost the same in this small pixel size.
$TOITC $CONVERT $TMP/roboto-medium-10.bdf "Roboto Regular" $OUT_100DPI/regular_10.toit

exit 0
