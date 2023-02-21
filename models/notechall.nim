import std/logging
import norm/model
import upload

addHandler newConsoleLogger(fmtStr = "")

type
  NoteChall* = ref object of Model
    upload*: Upload
    notes*: int

proc newNoteChall*(upload: Upload = newUpload(), notes: int = 1):NoteChall =
  NoteChall(upload: upload, notes: notes)
