import prologue
import std/jsonutils
import ../../models/[upload, notechall]
import ../../db

proc insertNoteChall(noteChall: var NoteChall) =
  echo "updating notChall"
  inDb: dbConn.insert noteChall

proc createNoteChall*(ctx: Context) {.async} =
  if ctx.request.reqMethod == HttpGet:
    resp "<p>invalid</p>"
  elif ctx.request.reqMethod == HttpPost:
    let body = ctx.request.body()
    let challJson = parseJson(body)
    var noteChall = to(challJson, NoteChall)
    let upload = getUploadByName(noteChall.upload.name)
    if isNil(upload):
        resp "<p>Does not exist</p>"
    insertNoteChall(noteChall)
    resp "done"

proc listNoteChalls*(ctx: Context) {.async} = 
  var noteChalls = @[newNoteChall()]
  inDb: dbConn.select(noteChalls, "upload IS NOT NULL")
  let asJson = toJson(noteChalls)
  ctx.response.setHeader "content-type", "application/json"
  resp jsonResponse(asJson)
