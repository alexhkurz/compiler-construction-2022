# Webassembly
  
The aim of this lecture is to understand how to compile by hand C++ to Webassembly. 
  
- We start with an example.
- We give a short introduction to Webassembly.
- We compile and run C++ programs in Webassembly using a tool chain.
- We learn how to compile by hand simple C++ programs to Webassembly.

## Example

As a recent example of an application that can be run in a browser thanks to Webassembly we use [this interactive webpage](https://olly.website/sims.html) on neural field models. As a side remark, the mathematics behind this goes back to Alan Turing's article [The Chemical Basis of Morphogenesis](https://en.wikipedia.org/wiki/The_Chemical_Basis_of_Morphogenesis).

Have a go and you will see that the patterns react to user input in real time.

The implementation posed a challenge since the fast Fourier transform (FFT) used to solve the differential equation needs to run in real time in the browser, client-side. While there are JavaScript libraries for FFT, they do not deliver the required performance. Instead, the mathematics was implemented in Rust and then compiled to Webassembly.

## Introduction

To quote from [webassembly.org](https://webassembly.org/):

    WebAssembly (abbreviated Wasm) is a binary instruction format for a 
    stack-based virtual machine. Wasm is designed as a portable target for 
    compilation of high-level languages like C/C++/Rust, enabling deployment 
    on the web for client and server applications.

Technically, Webassembly comes in two formats.

- A [binary format](https://webassembly.org/docs/binary-encoding/) (in `wasm`-files).

- A [text format](https://webassembly.org/docs/text-format/) of more human readable S-expressions (in `wat`-files).

In this lecture we will learn how to write Webassembly in the `wat`-format and then translate it to `wasm` and execute it.

## Technical Preliminaries

To run Webassembly programs we need to set up the necessary infrastructure.

### Installation

Start by installing `node.js` and the [Webassembly Binary Toolkit](https://github.com/WebAssembly/wabt).

- install [node.js](https://nodejs.org/en/)

To follow this lecture:

- make a local copy of [`Compiler-Assignment-Intro`](https://github.com/alexhkurz/compiler-construction-2021/tree/master/Compiler-Assignment-Intro)

- change directory to `Compiler-Assignment-Intro`

- install [wabt](https://www.npmjs.com/package/wabt)

      npm install wabt

### Compile C++ to Wat

In this lecture we will learn how to translate by hand simple C++ programs to WebAssembly, or to Wat, more precisely.

- Our running example is [`fibonacci.cc`](Compiler-Assignment-Intro/fibonacci.cc) from `/test/good`.
- Its translation is [`fibonacci.wat`](Compiler-Assignment-Intro/fibonacci.wat).

In order to run Wat programs we need to compile Wat to Wasm:

### Compile Wat to Wasm

Run

    node wat2wasm.js fibonacci.wat

This should create a file `fibonacci.wasm` (which is in binary).

### Run Wasm files

We first install the [scanf](https://www.npmjs.com/package/scanf) library for input and output.

    npm install scanf

Now we can run `fibonacci.wasm`:

    node run.js fibonacci.wasm

### Test Webassembly code against C++

To test whether the translation `fibonacci.wat` has the same observable behaviour as `fibonacci.cc`, run the two programs as follows.

#### Run the C++ program

- add the header `#include "env.h"` to `fibonacci.cc`
- make sure you have `env.h`, see [here](Compiler-Assignment-Intro/env.h)
- observe the behaviour of the C++ program:

      gcc fibonacci.cc -o fibonacci
      ./fibonacci

#### Run the Wat program

(we have done this above already)

- observe the behaviour of the Wasm program:

        node wat2wasm.js fibonacci.wat
        node run.js fibonacci.wasm
  

## Stack-based languages

A stack-based programming language operates by pushing and popping values onto a stack as it operates. We therefore have to translate operations, usually written as nested infix syntax, into operations using the stack. This is sometimes referred to as the [reverse polish notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation). As a simple example, let's see how we would compute the expression

    (2 + 4) * 6

In terms of the operations we need to perform, we have to:

-   Push `2` onto the stack
-   Push `4` onto the stack
-   Add the two arguments on the stack and push the result back onto the stack
-   Push `6` onto the stack
-   Multipy the two arguments on the stack and push the result back onto the stack

We can write these steps in the reverse polish notation as

    2 4 + 6 *

And when translated into webassembly, we get:

    (i32.const 2)
    (i32.const 4)
    i32.add
    (i32.const 6)
    i32.mul


**You could test this quickly in: https://webassembly.github.io/wabt/demo/wat2wasm/ by pasting the following in:**

WAT:

    (module
        (func (export "test") (result i32)
            (i32.const 2)
            (i32.const 4)
            i32.add
            (i32.const 6)
            i32.mul
            return
        )
    )

JS:

    const wasmInstance =
      new WebAssembly.Instance(wasmModule, {});
    const { test } = wasmInstance.exports;
    console.log(test());

**Exercise:** Change the values in the WAT program and observe the different outputs in the lower right window.

## Translate C++ to Wat

What is the best way to learn Webassembly?

One important resource is the [language definition](https://webassembly.github.io/spec/core/text/index.html) at webassembly.org. In particular, you should at least glance at

- the [typing rules](https://webassembly.github.io/spec/core/valid/index.html) and
- the [operational semantics](https://webassembly.github.io/spec/core/exec/index.html).

But while these are the most important references, this is not a necessarily the best starting point.

Instead we take a language we know, C++, and see how to translate it to Wasm (or, rather, Wat).

We compare line by line the C++ program

    int main () {
      int lo,hi,mx ;
      lo = 1 ;
      hi = lo ;
      mx = 5000000 ;
      printInt(lo) ;
      while (hi < mx) {
        printInt(hi) ;
        hi = lo + hi ;
        lo = hi - lo ;
      }
      return 0 ;
    
    }

and the compiled Webassembly program

    (module
     (import "env" "readInt" (func $readInt (result i32)))
     (import "env" "readDouble" (func $readDouble (result f64)))
     (import "env" "printInt" (func $printInt (param i32)))
     (import "env" "printDouble" (func $printDouble (param f64))    )
     (func
      $main
      (result i32)
      (local $ilo$0 i32)
      (local $ihi$0 i32)
      (local $imx$0 i32)
      (i32.const 1)
      (local.set $ilo$0)
      (local.get $ilo$0)
      (local.set $ihi$0)
      (i32.const 5000000)
      (local.set $imx$0)
      (local.get $ilo$0)
      (call $printInt)
      (block
       (loop
        (local.get $ihi$0)
        (local.get $imx$0)
        i32.lt_s
        i32.eqz
        (br_if 1)
        (local.get $ihi$0)
        (call $printInt)
        (local.get $ilo$0)
        (local.get $ihi$0)
        i32.add
        (local.set $ihi$0)
        (local.get $ihi$0)
        (local.get $ilo$0)
        i32.sub
        (local.set $ilo$0)
        (br 0)
       )
      )
      (i32.const 0)
      return
     )
     (export "main" (func $main))
    )

**Activity:** Make a table matching the C++ program and the WAT program line by line. ([Answer](Compiler-Assignment-Intro/fibonacci.md).)

**Exercise:** Translate to Wat the program [ass_in_arith-short.cc](Compiler-Assignment-Intro/ass_in_arith-short.cc):

    int main() {
      int x = 50;
      int y = x+++x--;
      printInt(y);
      printInt(x);
      return 0;
    }

Test your `ass_in_arith-short.wat` as described [above](lecture-12.1.md#test-webassembly-code-against-c).

## References

A good reference for the topic of this lecture is the article

- [Writing WebAssembly By Hand](https://blog.scottlogic.com/2018/04/26/webassembly-by-hand.html).

To learn more about Webassembly, here are articles about how to write a type checker for Webassembly

- [Learning the Webassembly type system](https://maurobringolf.ch/2018/04/learning-the-webassembly-type-system/)

and how to write a compiler for Webassembly

- [Build your own WebAssembly Compiler](https://blog.scottlogic.com/2019/05/17/webassembly-compiler.html).

### General references

- [Webassembly.org](https://webassembly.org)

- [Webassembly Specification](https://webassembly.github.io/spec/core/)

- [WebAssembly at MDN](https://developer.mozilla.org/en-US/docs/WebAssembly)
