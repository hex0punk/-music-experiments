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

proc reorderNotes*(self: Scale, fromIdx: int): seq[string] =
    return Notes[fromIdx .. len(Notes)-1] & Notes[0 .. fromIdx]

proc reorderIntervalsForMode*(self: Scale, mode: Mode): seq[Intervals] = 
    var modeIdx = ord(mode)
    return BaseIntervals[modeIdx .. len(BaseIntervals)-1] & BaseIntervals[0 .. modeIdx - 1]

proc reorderChordsForMode*(self: Scale, mode: Mode): seq[Chords] = 
    var modeIdx = ord(mode)
    return BaseChords[modeIdx .. len(BaseChords)-1] & BaseChords[0 .. modeIdx - 1]

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
    self.optimizeKey()
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
    var notes = self.getMajorForKey()
    var res = newSeq[string]()
    for idx, note in notes:
        echo note & $BaseChords[idx]
        res.add(note & $BaseChords[idx])
    return res

proc getScaleForMode*(self: Scale, mode: Mode): seq[string] =
    self.optimizeKey()
    var orderedIntervals = self.reorderIntervalsForMode(mode)
    var res = newSeq[string]()
    res.add(self.key)
    for idx, inter in orderedIntervals:
        var prev = res[idx]
        if inter == Intervals.Tone:
            res.add(self.addTone(prev))
        else:
            res.add(self.semiTone(prev))
    return res

proc getChordsForMode*(self: Scale, mode: Mode): seq[string] =
    var notes = self.getScaleForMode(mode)
    var reorderedChords = self.reorderChordsForMode(mode)
    echo reorderedChords
    var res = newSeq[string]()
    for idx, note in notes:
        echo note & $reorderedChords[idx]
        res.add(note & $reorderedChords[idx])
    return res
