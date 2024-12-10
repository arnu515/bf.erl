# bf.erl

Very simple [Brainfuck](https://wikipedia.org/wiki/Brainfuck) interpreter in erlang.

No loop support yet!

## Usage

### Use directly

```erl
bf:interpret(
  "Hello", % initial state. MUST be of length 1 atleast. Elements are reversed, and the first element is the cursor's position
  ", world!", % state after the cursor
  $.,
  "+++---<.<.<.<.>>>>>.>.>.>.>.>.>.>.,."
)
```

### Interpret files

```shell
escript bf.erl file1.bf file2.bf ...
```
