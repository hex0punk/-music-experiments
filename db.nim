import norm/sqlite
export sqlite

import std/locks
# export locks

var dbLock*: Lock
initLock dbLock

var dbConn* {.guard: dbLock.}: DbConn

template inDb*(body: untyped) =
  ## This is a simple template to edit db using locks to be `gcsafe`
  {.gcsafe.}:
    withLock dbLock:
      body