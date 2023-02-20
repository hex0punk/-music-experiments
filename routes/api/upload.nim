import prologue
import ../../models/upload
import ../../db

proc updateUpload*(song: var Upload) =
  echo "updating song"
  inDb: dbConn.insert song

proc createUpload*(ctx: Context) {.async} =
  if ctx.request.reqMethod == HttpGet:
    resp "<p>invalid</p>"
  elif ctx.request.reqMethod == HttpPost:
    echo ctx.request.body
    let file = ctx.getUploadFile("file")
    echo "saving...."
    file.save("user_uploads/")
    # file.save("tests/assets/temp", "set.txt")
    resp "Done"