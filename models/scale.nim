import std/logging
import ../utils/[formulas, noteUtils]

addHandler newConsoleLogger(fmtStr = "")

type
  Scale* = ref object
    key*: string
    mode*: Mode
    optimized*: bool

proc newScale*(key: string, mode: Mode = Ionian, optimized: bool = false): Scale =
  Scale(key: key, mode: mode, optimized: optimized)

proc addTone(self: Scale, note: string): string =
    var idx = indexForNote($note[0])
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
    var idx = indexForNote($note[0])
    case note:
    of "C#", "D#", "F#", "G#", "A#", "B", "E", "Cb", "Db", "Fb", "Gb", "Ab":
        return Notes[idx + 1] 
    of "E#", "B#":
        return Notes[idx + 1] & "#"
    of "C", "D", "F", "G", "A", "Eb", "Bb":
        return Notes[idx + 1] &  "b"
    else:
        return note

proc reorderNotes*(self: Scale, fromIdx: int): seq[string] =
    return Notes[fromIdx .. len(Notes)-1] & Notes[0 .. fromIdx]

proc reorderIntervalsForMode*(self: Scale): seq[Intervals] = 
    var modeIdx = ord(self.mode)
    return BaseIntervals[modeIdx .. len(BaseIntervals)-1] & BaseIntervals[0 .. modeIdx - 1]

proc reorderChordsForMode*(self: Scale): seq[Chords] = 
    var modeIdx = ord(self.mode)
    return BaseChords[modeIdx .. len(BaseChords)-1] & BaseChords[0 .. modeIdx - 1]

proc optimizeKey(self: Scale) = 
    self.optimized = true
    case self.key:
    of "D#": self.key = "Eb"
    of "E#": self.key = "F"
    of "G#": self.key = "Ab"
    of "A#": self.key = "Bb"
    of "B#": self.key = "C"
    of "Fb": self.key = "E"
    else: 
        self.optimized = false

proc getScaleForMode*(self: Scale): seq[string] =
    self.optimizeKey()
    var orderedIntervals = self.reorderIntervalsForMode()
    var res = newSeq[string]()
    res.add(self.key)
    for idx, inter in orderedIntervals:
        var prev = res[idx]
        if inter == Intervals.Tone:
            res.add(self.addTone(prev))
        else:
            res.add(self.semiTone(prev))
    return res

proc getChordsForMode*(self: Scale): seq[string] =
    var notes = self.getScaleForMode()
    var reorderedChords = self.reorderChordsForMode()
    var res = newSeq[string]()
    for idx, note in notes:
        res.add(note & $reorderedChords[idx])
    return res