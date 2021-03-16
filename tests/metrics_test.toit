// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an Apache-style license that can be
// found in the LICENSE file.

import font show *
import roboto.regular_14 as r14
import roboto.black_italic_36 as bi36
import expect show *

main:
  R14 := Font [r14.ASCII, r14.CURRENCY_SYMBOLS]

  expect_equals 7
    R14.pixel_width "x"

  expect_equals 8
    R14.pixel_width "€"

  expect_list_equals [75, 13, 1, -2]
    R14.text_extent "Hello, World!"

  BI36 := Font [bi36.ASCII, bi36.LATIN_1_SUPPLEMENT]

  expect_equals 18
    BI36.pixel_width "x"

  expect_list_equals [118, 11, 0, 0]
    R14.text_extent "Søen så sær ud!"
