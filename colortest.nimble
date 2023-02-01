# Package

version       = "0.1.0"
author        = "z-kk"
description   = "color test program"
license       = "MIT"
srcDir        = "src"
bin           = @["colortest"]
binDir        = "bin"


# Dependencies

requires "nim >= 1.2.0"


# Tasks

import std / [os, strutils]
task r, "make link and run":
  exec "nimble -d:Version=v$1 build" % [version]
  exec "nimble ex"

task ex, "run without build":
  withDir binDir:
    exec "." / bin[0]
