import prologue
import strutils
import ../../models/scale
import ../../data/formulas
# import std/jsonutils
# import ../../models/upload
# import ../../db

proc scale*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = Scale(name: "", key: key)
    let scale = sc.getMajorForKey()
    var result = %*scale
    resp jsonResponse(result)

proc getChords*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = Scale(name: "", key: key)
    let chords = sc.getMajorChordsForKey()
    var result = %*chords
    resp jsonResponse(result)

proc scaleMode*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    let mode = ctx.getQueryParamsOption("mode").get()
    var sc = Scale(name: "", key: key)
    let scale = sc.getScaleForMode(Mode(parseInt(mode) - 1))
    var result = %*scale
    resp jsonResponse(result)

proc getChordsForMode*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    let mode = ctx.getQueryParamsOption("mode").get()
    var sc = Scale(name: "", key: key)
    let chords = sc.getChordsForMode(Mode(parseInt(mode) - 1))
    var result = %*chords
    resp jsonResponse(result)