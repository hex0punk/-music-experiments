# Music Experiments with Nim and JS

## Setup

1. Install nim 

```shell
$ brew install nim
```

2. Install IDE extentions:

- https://marketplace.visualstudio.com/items?itemName=nimsaem.nimvscode

3. Install dependencies

```shell
$ nimble install prologue
...
$ nimble install norm
...
$ 
```

- For `prologue`, select `y` when asked if package.json should be downloaded

4. Run nim backend

```shell
$ nim c -r app.nim
```

Alternatively, add `~/.nimble/bin` to your path and run `logue run`.





