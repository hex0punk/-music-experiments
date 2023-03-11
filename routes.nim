import prologue
import routes/home
import routes/api/[upload, notechall, scales]

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
    ("api/scales", @[
      pattern("/scale", scale, HttpGet, "api_scale"),
      pattern("/chords", getChords, HttpGet, "api_chords")
    ]),
    ("api/notechall", @[
      pattern("/create", createNoteChall, HttpPost, "api_createNoteChall"),
      pattern("/list", listNoteChalls, HttpGet, "api_listNoteChalls")
    ]),
  ]