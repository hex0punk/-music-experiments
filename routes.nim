import prologue
import routes/home
import routes/api/upload

type
  Route = tuple
    path: string
    routes: seq[UrlPattern]

const
  routesDefinition*: seq[Route] = @[
    ("", @[
      pattern("/", index, HttpGet, "home"),
    ]),
    ("api/file", @[
      pattern("/upload", createUpload, HttpPost, "api_createUpload"),
      pattern("/uploads", listUploads, HttpGet, "api_listUploads")
    ]),
  ]