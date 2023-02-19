import ../db
import ../models/[user, upload]
import norm/sqlite
import std/logging

addHandler newConsoleLogger(fmtStr = "")

proc setup*(conn: DbConn) =
  conn.createTables(newUser())
  conn.createTables(newUpload())
