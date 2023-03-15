import prologue
import strutils
import ../../models/scale
import ../../data/formulas

proc scale*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = newScale(key)
    let scale = sc.getScaleForMode()
    var result = %*scale
    resp jsonResponse(result)

proc getChords*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    var sc = newScale(key)
    let chords = sc.getChordsForMode()
    var result = %*chords
    resp jsonResponse(result)

proc scaleMode*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    let modeParam = ctx.getQueryParamsOption("mode").get()
    let mode = Mode(parseInt(modeParam))
    var sc = newScale(key, mode)
    let scale = sc.getScaleForMode()
    var result = %*scale
    resp jsonResponse(result)

proc getChordsForMode*(ctx: Context) {.async.} =
    let key = ctx.getQueryParamsOption("key").get()
    let modeParam = ctx.getQueryParamsOption("mode").get()
    let mode = Mode(parseInt(modeParam))
    var sc = newScale(key, mode)
    let chords = sc.getChordsForMode()
    var result = %*chords
    resp jsonResponse(result)