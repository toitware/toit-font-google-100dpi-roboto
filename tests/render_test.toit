// Copyright (C) 2023 Toitware ApS. All rights reserved.
// Use of this source code is governed by an Apache-style license that can be
// found in the LICENSE file.

import bitmap show bitmap_draw_text
import font show *
import roboto.black_italic_64 as bi64
import expect show *

main:
  BI64 := Font [bi64.ASCII, bi64.LATIN_EXTENDED_ADDITIONAL]

  expect_list_equals [38, 73, 0, -15]
    BI64.text_extent "Ḝ"

  WIDTH := 40
  HEIGHT := 80
  BYTE_HEIGHT := HEIGHT / 8
  bit_map := ByteArray WIDTH * BYTE_HEIGHT

  COLOR ::= 1
  ORIENTATION ::= 0

  bitmap_draw_text 1 (HEIGHT - 16) COLOR ORIENTATION "Ḝ" BI64 bit_map WIDTH

  BYTE_HEIGHT.repeat: | y1 |
    4.repeat: | y2 |
      line := bit_map[y1 * WIDTH..(y1 + 1) * WIDTH]
      mask1 := 1 << (y2 * 2)
      mask2 := 1 << (y2 * 2 + 1)
      str := ""
      line.do:
        top := (it & mask1 != 0) ? 1 : 0
        bot := (it & mask2 != 0) ? 2 : 0
        str += [" ", "▀", "▄", "█"][top + bot]
      if y1 == 1 and y2 == 1: expect_equals "                 ████████▄▄▄████████▀   " str
      print str

