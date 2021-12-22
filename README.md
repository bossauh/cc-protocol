# CC Protocol
Warning: Documentation is terrible.

# What is this?
This is a way for computercraft to interact with other programming languages without the use of a web server. All communication is done via files. This obviously comes with a lot of problems but to mitigate those problems, there are certain guidelines that has to be followed.

This is usually only for single player as you would have to modify game files in order to execute commands.

## Input
In order to run a command, lua is constantly reading the `__in.coms` file. If it sees a text resembling a command, it will then run that command. That file is always being cleared as soon as it receives an input and you should not clear it on your own to prevent errors.

### Commands Format
```
-- Example
turtle getItemDetail 1 true

-- Format
module function argument1 argument2 ...
```

## Output
The output is then returned in the `__out.json` file. That file always has to be cleared after you run a command or else the clear signal will not be written to it. (See clear signal below)

### Clear Signal
The clear signal is a special kind of output. It basically says that you are clear for running other commands. `__out.json` is always in the clear signal state if nothing is happening.
```js
// Inside __out.json
{
    "status": "clear",
    "msg": "clear",
    "out": "clear",
    "command": {}
}
```

### Successful Format
Here you can see the format of `__out.json` if a command is successful.
```js
{
    "status": "ok",
    "msg": "ok",
    "out": "blah blah your shit ran successfully here's the result for yes", // The return of the function you called
    "command": {
        // Information about the command you ran
        "module": "turtle",
        "function": "getItemDetail",
        "args": [
            "1",
            "true"
        ]
    }
}
```

### Exception Format
Here you can see the format of `__out.json` if a command fails to run.
```js
{
    "status": "woahCoolException",
    "msg": "Your shit failed bruv and here's why"
}
```

### Exceptions
`commandEmpty` :
    Raised when the `__in.coms` reads empty. This is usually not written in the `__out.coms` file.

`moduleNotFound` :
    Raised when a module you're trying to run is either not available or does not fucking exist at all.

`functionNotFound` :
    Raised when a function you're trying to run is you know how it goes...

