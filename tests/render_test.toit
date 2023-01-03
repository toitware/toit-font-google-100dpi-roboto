// Copyright (C) 2021 Toitware ApS. All rights reserved.
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
  HEIGHT := 96
  BYTE_HEIGHT := HEIGHT / 8
  bit_map := ByteArray WIDTH * BYTE_HEIGHT

  COLOR ::= 1
  ORIENTATION ::= 0

  bitmap_draw_text 1 (HEIGHT - 16) COLOR ORIENTATION "Ḝ" BI64 bit_map WIDTH

  BYTE_HEIGHT.repeat: | y1 |
    8.repeat: | y2 |
      line := bit_map[y1 * WIDTH..(y1 + 1) * WIDTH]
      mask := 1 << y2
      str := ""
      line.do: str += it & mask == 0 ? " " : "█"
      if y1 == 3 and y2 == 2: expect_equals "                 ████████   █████████   " str
      print str

