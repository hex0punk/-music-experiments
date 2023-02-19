import std/logging
import norm/model
import upload

addHandler newConsoleLogger(fmtStr = "")

type
  Song* = ref object of Model
    title*: string
    artist*: string
    upload*: Upload

proc newSong*(title: string = "", artist: string, upload: Upload = newUpload()): Song =
  Song(title: title, artist: artist, upload: upload)
