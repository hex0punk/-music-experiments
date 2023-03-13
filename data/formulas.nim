type
  Chords* {.pure.} = enum
    Major = ""
    Minor = "m"
    Dim = "dim"
  Intervals* {.pure.} = enum
    SemiTone = 1, 
    Tone = 2
  Mode* {.pure.} = enum
    Ionian,
    Dorian,
    Phrygian,
    Lydian,  
    Mixolydian,
    Aeolian,
    Locrian 
 
const
    Notes* = @["C", "D", "E", "F", "G", "A", "B", "C"]

const
    BaseIntervals* = @[Tone, Tone, SemiTone, Tone, Tone, Tone, SemiTone]
    BaseChords* = [Major, Minor, Minor, Major, Major, Minor, Dim, Major]