import ../scale
discard """
  errormsg: "undeclared identifier: 'not_defined'"
"""

var sc = Scale(name: "", key: "C")
var res = sc.getMajorForKey()
echo res
assert res == @["C", "D", "E", "F", "G", "A", "B", "C"]