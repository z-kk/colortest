import
  std / [strformat]

proc echoColor(i: int) =
  stdout.write "\e[38;5;{i}m {i:3}".fmt

when isMainModule:
  for i in 0 ..< 2:
    for j in 0 ..< 8:
      echoColor(i * 8 + j)
    echo ""
  echo ""

  for i in 0 ..< 12:
    for j in 0 ..< 3:
      for k in 0 ..< 6:
        echoColor(16 + i * 6 + j * 6 * 6 * 2 + k)
      stdout.write " "
    echo ""
    if (i + 1) mod 6 == 0:
      echo ""

  for i in 0 ..< 2:
    for j in 0 ..< 12:
      echoColor(16 + 6 * 6 * 6 + i * 12 + j)
    echo ""
