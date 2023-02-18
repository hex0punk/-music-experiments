import prologue
import ../../models/song
import ../../db

proc updateSong*(song: var Song) =
  echo "updating song"
  inDb: dbConn.insert song

proc createSong*(ctx: Context) {.async} =
  let body = ctx.request.body()
  let songJson = parseJson(body)
  var toSong = newSong()
  toSong.title = songJson["title"].getStr()
  toSong.path = songJson["path"].getStr()
  echo "calling method"
  updateSong(toSong)
  resp "Done"