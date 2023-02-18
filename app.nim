import std/logging
import prologue
import prologue/middlewares/utils

import db
import db/setup
import routes

let
  env = loadPrologueEnv(".env")
  settings = newSettings(appName = env.getOrDefault("appName", "Prologue"),
                         debug = env.getOrDefault("debug", true),
                         port = Port(env.getOrDefault("port", 8080)),
                         secretKey = env.getOrDefault("secretKey", "")
    )

proc main =
  inDb:
    dbConn = open(":memory:", "", "", "")
    setup dbConn

  proc setLoggingLevel(settings: Settings; errorLog, rollingLog: string): auto =
    result = proc =
      addHandler newFileLogger(errorLog, levelThreshold = lvlError)
      addHandler newRollingFileLogger rollingLog
      addHandler(newConsoleLogger())
      if settings.debug:
        logging.setLogFilter(lvlDebug)
      else:
        logging.setLogFilter(lvlInfo)

  var app = newApp(
    settings = settings,
        startup = @[
      initEvent(settings.setLoggingLevel("error.log", "rolling.log"))
    ]
  )

  app.use(@[
    debugRequestMiddleware(),
  ])

  for r in routesDefinition:
    app.addRoute(r.routes, r.path)
  app.run()

when isMainModule:
  main()
else:
  {.fatal: "This module cannot be imported.".}
