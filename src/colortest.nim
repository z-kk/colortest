import
  std / [os, strutils, strformat],
  docopt,
  colortestpkg / [version]

type
  cmdOpt = object
    fg: int
    bg: int

let
  appName = getAppFilename().extractFilename

proc readOpt(): cmdOpt =
  ## Read command line options.
  let doc = ("""
    $1

    Usage:
      $1 [-f <fgcolor> | -b <bgcolor>]

    Options:
      -h --help     Show this screen.
      -v --version  Show version.
      -f --fgcolor  Set foreground color[0-255].
      -b --bgcolor  Set background color[0-255].
  """ % [appName]).dedent
  let args = doc.docopt(version = Version)

  result.fg = -1
  result.bg = -1
  if args["--fgcolor"]:
    try:
      result.fg = parseInt($args["<fgcolor>"])
      if result.fg notin 0 .. 255:
        quit doc
    except:
      quit doc
  if args["--bgcolor"]:
    try:
      result.bg = parseInt($args["<bgcolor>"])
      if result.bg notin 0 .. 255:
        quit doc
    except:
      quit doc

proc echoColor(opt: cmdOpt, i: int) =
  let
    f = if opt.fg < 0: i else: opt.fg
    b = if opt.bg < 0: i else: opt.bg
  if opt.fg * opt.bg <= 0:
    stdout.write "\e[48;5;{b}m".fmt
  stdout.write "\e[38;5;{f}m {i:3}".fmt
  stdout.write "\e[m"

when isMainModule:
  let opt = readOpt()
  for i in 0 ..< 2:
    for j in 0 ..< 8:
      opt.echoColor(i * 8 + j)
    echo ""
  echo ""

  for i in 0 ..< 12:
    for j in 0 ..< 3:
      for k in 0 ..< 6:
        opt.echoColor(16 + i * 6 + j * 6 * 6 * 2 + k)
      stdout.write "  "
    echo ""
    if (i + 1) mod 6 == 0:
      echo ""

  for i in 0 ..< 2:
    for j in 0 ..< 12:
      opt.echoColor(16 + 6 * 6 * 6 + i * 12 + j)
    echo ""
