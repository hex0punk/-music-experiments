import prologue
import ../../models/scale
# import std/jsonutils
# import ../../models/upload
# import ../../db

proc scale*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = Scale(name: "", key: key)
    let scale = sc.getMajorForKey()
    var result = %*scale
    resp jsonResponse(result)

proc chords*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = Scale(name: "", key: key)
    echo "calling func"
    let chords = sc.getMajorChordsForKey()
    var result = %*chords
    resp jsonResponse(result)

