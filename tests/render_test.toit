// Copyright (C) 2023 Toitware ApS. All rights reserved.
// Use of this source code is governed by an Apache-style license that can be
// found in the LICENSE file.

import bitmap show bitmap-draw-text
import font show *
import roboto.black-italic-64 as bi64
import expect show *

main:
  BI64 := Font [bi64.ASCII, bi64.LATIN-EXTENDED-ADDITIONAL]

  expect-list-equals [38, 73, 0, -15]
    BI64.text-extent "Ḝ"

  WIDTH := 40
  HEIGHT := 80
  BYTE-HEIGHT := HEIGHT / 8
  bit-map := ByteArray WIDTH * BYTE-HEIGHT

  COLOR ::= 1
  ORIENTATION ::= 0

  bitmap-draw-text 1 (HEIGHT - 16) COLOR ORIENTATION "Ḝ" BI64 bit-map WIDTH

  BYTE-HEIGHT.repeat: | y1 |
    4.repeat: | y2 |
      line := bit-map[y1 * WIDTH..(y1 + 1) * WIDTH]
      mask1 := 1 << (y2 * 2)
      mask2 := 1 << (y2 * 2 + 1)
      str := ""
      line.do:
        top := (it & mask1 != 0) ? 1 : 0
        bot := (it & mask2 != 0) ? 2 : 0
        str += [" ", "▀", "▄", "█"][top + bot]
      if y1 == 1 and y2 == 1: expect-equals "                 ████████▄▄▄████████▀   " str
      print str

