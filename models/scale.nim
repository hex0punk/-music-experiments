import std/logging
import std/strutils
import ../data/formulas

addHandler newConsoleLogger(fmtStr = "")

type
  Scale* = ref object
    name*: string
    key*: string

proc indexForKey(self: Scale): int =
    for idx, note in Notes:
        if note == $self.key[0]:
            return idx
    return -1

proc indexForNote(self: Scale, note: string): int =
    for idx, n in Notes:
        if n == note:
            return idx
    return -1

proc addTone(self: Scale, note: string): string =
    var idx = self.indexForNote($note[0])
    case note:
    of "A", "C", "D", "F", "G", "Bb", "Eb":
        return Notes[idx + 1]
    of "A#", "C#", "D#", "F#", "G#", "B", "E":
        return Notes[idx + 1] & "#"
    of "Ab", "Cb", "Db", "Fb", "Gb":
        return Notes[idx + 1] & "b"
    else:
        return note

proc semiTone(self: Scale, note: string): string = 
    var idx = self.indexForNote($note[0])
    case note:
    of "E#", "B#":
        return Notes[idx + 1] & "#"
    of "C#", "D#", "F#", "G#", "A#", "B", "E":
        return Notes[idx + 1] 
    of "Cb", "Db", "Fb", "Gb", "Ab":
        return Notes[idx + 1] 
    of "C", "D", "F", "G", "A", "Eb", "Bb":
        return Notes[idx + 1] &  "b"
    else:
        return note

proc reorderNotes(self: Scale, fromIdx: int): seq[string] =
    return Notes[fromIdx .. len(Notes)-1] & Notes[0 .. fromIdx]

proc optimizeKey(self: Scale) = 
    case self.key:
    of "D#": self.key = "Eb"
    of "E#": self.key = "F"
    of "G#": self.key = "Ab"
    of "A#": self.key = "Bb"
    of "B#": self.key = "C"
    of "Fb": self.key = "E"
    else: return

proc getMajorForKey*(self: Scale): seq[string] =
    echo "getting notes for " & self.key
    self.optimizeKey()
    var keyidx: int = self.indexForKey()
    var orderedNotes = self.reorderNotes(keyidx)
    echo "ordered: " & intToStr(len(orderedNotes))
    echo orderedNotes
    var res = newSeq[string]()
    res.add(self.key)
    for idx, inter in BaseIntervals:
        var prev = res[idx]
        if inter == Intervals.Tone:
            res.add(self.addTone(prev))
        else:
            res.add(self.semiTone(prev))
    return res

proc getMajorChordsForKey*(self: Scale): seq[string] =
    echo "test"
    var notes = self.getMajorChordsForKey()
    var res = newSeq[string]()
    echo "iterrrr"
    for idx, note in notes:
        echo note & $BaseChords[idx]
        res.add(note & $BaseChords[idx])
    return res


