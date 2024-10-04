// Copyright (C) 2021 Toitware ApS. All rights reserved.
// Use of this source code is governed by an Apache-style license that can be
// found in the LICENSE file.

import font show *
import roboto.regular-14 as r14
import roboto.black-italic-64 as bi64
import expect show *

main:
  R14 := Font [r14.ASCII, r14.CURRENCY-SYMBOLS]

  expect-equals 7
    R14.pixel-width "x"

  expect-equals 8
    R14.pixel-width "€"

  expect-list-equals [75, 13, 1, -2]
    R14.text-extent "Hello, World!"

  BI64 := Font [bi64.ASCII, bi64.LATIN-1-SUPPLEMENT, bi64.LATIN-EXTENDED-ADDITIONAL]

  expect-equals 32
    BI64.pixel-width "x"

  expect-list-equals [186, 76, 0, -15]
    BI64.text-extent "JLgÅḜ"

  expect-list-equals [118, 11, 0, 0]
    R14.text-extent "Søen så sær ud!"
