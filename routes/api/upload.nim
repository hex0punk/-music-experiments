import prologue
import ../../models/upload
import ../../db

proc updateUpload*(song: var Upload) =
  echo "updating song"
  inDb: dbConn.insert song

proc createUpload*(ctx: Context) {.async} =
  echo "called"
  let body = ctx.request.body()
  let uploadJson = parseJson(body)
  # var toUpload = newUpload()
  # toUpload.name = uploadJson["name"].getStr()
  # toUpload.path = uploadJson["path"].getStr()
  # echo "calling method"
  # updateUpload(toUpload)
  echo uploadJson["name"].getStr()
  let file = ctx.getUploadFile("file")
  echo "saving...."
  file.save("tests/assets/temp")
  file.save("tests/assets/temp", "set.txt")
  resp "Done"