import prologue

proc index*(ctx: Context) {.async.} =
  resp "<h1>Hello, Prologueeeee!</h1>"

proc hello*(ctx: Context) {.async.} =
  resp ctx.urlFor("index")

proc hola*(ctx: Context) {.async.} =
  resp "Hola"

proc hi*(ctx: Context) {.async.} =
  resp "Hi"

proc home*(ctx: Context) {.async.} =
  resp "Home"


# curl -X POST http://localhost:8080/apiv2/song/create
#    -H 'Content-Type: application/json'
#    -d '{"login":"my_login","password":"my_password"}'