import std/logging
import norm/model
import ../db

addHandler newConsoleLogger(fmtStr = "")

type
  Upload* = ref object of Model
    name*: string
    path*: string

proc newUpload*(name, path = ""): Upload =
  Upload(name: name, path: path)

proc getUploadByName*(name: string): Upload =
  var upload = newUpload()
  inDb: dbConn.select(upload, "name = ?", name)
  return upload