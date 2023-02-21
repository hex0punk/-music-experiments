import prologue
import std/jsonutils
import ../../models/upload
import ../../db

proc insertUpload(upload: var Upload) =
  echo "updating upload"
  inDb: dbConn.insert upload

proc createUpload*(ctx: Context) {.async} =
  if ctx.request.reqMethod == HttpGet:
    resp "<p>invalid</p>"
  elif ctx.request.reqMethod == HttpPost:
    echo ctx.request.body
    let file = ctx.getUploadFile("file")
    echo "saving...."
    file.save("user_uploads/")
    # file.save("tests/assets/temp", "set.txt")
    var 
      upload = newUpload(file.filename, "user_uploads/" & file.filename)
    insertUpload(upload)
    resp "Done"

proc listUploads*(ctx: Context) {.async} = 
  var uploads = @[newUpload()]
  inDb: dbConn.select(uploads, "name IS NOT NULL")
  let asJson = toJson(uploads)
  ctx.response.setHeader "content-type", "application/json"
  resp jsonResponse(asJson)

