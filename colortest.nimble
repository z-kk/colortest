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
requires "docopt"


import std / [os, strutils]

# Before

before build:
  let versionFile = srcDir / bin[0] & "pkg" / "version.nim"
  versionFile.parentDir.mkDir
  versionFile.writeFile("const Version* = \"$1\"\n" % version)


# After

after build:
  let versionFile = srcDir / bin[0] & "pkg" / "version.nim"
  versionFile.writeFile("const Version* = \"\"\n")
