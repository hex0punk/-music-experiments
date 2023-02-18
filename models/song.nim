import std/logging
import norm/model

addHandler newConsoleLogger(fmtStr = "")

type
  Song* = ref object of Model
    title*: string
    path*: string

proc newSong*(title, path = ""): Song =
  Song(title: title, path: path)


# proc createTables*() = 
#   let dbConn = open(":memory:", "", "", "")
#   dbConn.createTables(newUser())
#   dbConn.createTables(newSong())
#   echo("tables created")