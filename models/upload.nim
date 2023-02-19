import std/logging
import norm/model

addHandler newConsoleLogger(fmtStr = "")

type
  Upload* = ref object of Model
    name*: string
    path*: string

proc newUpload*(name, path = ""): Upload =
  Upload(name: name, path: path)