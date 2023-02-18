import prologue
import routes/home
import routes/api/song

type
  Route = tuple
    path: string
    routes: seq[UrlPattern]

const
  routesDefinition*: seq[Route] = @[
    ("", @[
      pattern("/", index, HttpGet, "home"),
    ]),
    ("api/song", @[
      pattern("/create", createSong, HttpPost, "api_createSong"),
    ]),
  ]