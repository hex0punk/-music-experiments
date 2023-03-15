
import formulas

## TODO: Some general methods to move elsewhere at one point
proc indexForNote*(note: string): int =
    for idx, n in Notes:
        if n == note:
            return idx
    return -1