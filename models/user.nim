import norm/model

type
  User* = ref object of Model
    email*:  string

proc newUser*(email = ""): User = 
  User(email: email)