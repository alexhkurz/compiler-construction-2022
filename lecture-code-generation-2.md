# Writing Webassembly, continued

We are going to practice some more Webassembly writing. The emphasis is not on learning to write Webassembly programs that can do cool stuff, but on writing programs that help you understand how to compile C++ programs to Webassembly.

We start with variations on the program `return_in_while` from the good test programs.

Go to the [wat2wasm demo](https://webassembly.github.io/wabt/demo/wat2wasm/). Copy into the JS window on the lower left

    const wasmInstance =
          new WebAssembly.Instance(wasmModule, {});
    const { main } = wasmInstance.exports;
    console.log(main());

In the Wat window on the upper left copy

    (module
     (func 
      $main
      (result i32)
      (i32.const 52)
      return
     )
     (export "main" (func $main))
    )
    
You may have to type something in the JS window now. Then you should see 52 in the browser window on the lower right.
    
    

**Exercise 1:** Write a Webassembly program that has the same observable behaviour as [`return-in-while-1.cc`](Compiler-Assignment-Intro/return-in-while-1.cc):

    int main() {
      int i = 0;
      return 52;
    }

Then change the code to return the value of `i` instead.

**Remark:** The return value of `main()` can be displayed as follows.

    gcc return-in-while-1.cc
    ./a.out
    echo $?

**Hint:** Use [`fibonacci.wat`](Compiler-Assignment-Intro/fibonacci.wat) as a template. The programs in this lecture do not contain input/output, so ignore the `import` statements in the Webassembly.

**Exercise 2:** Write a Webassembly program that has the same observable behaviour as [`return-in-while-2.cc`](Compiler-Assignment-Intro/return-in-while-2.cc):

    int main() {
      int i = 0;
    
      while (i++ < 5) {
      }
    
      return i;
    }

**Exercise 2b:** In your Webassembly program, try to find out the meaning of `block`, `loop`, `br_if` and `br` by changing your program in various ways, predicting and observing how the behaviour changes. See also the article [Solving the structured control flow problem once and for all](https://medium.com/leaningtech/solving-the-structured-control-flow-problem-once-and-for-all-5123117b1ee2) for a discussion. 
    
**Exercise 3:** Write a Webassembly program that has the same observable behaviour as [`return-in-while.cc`](Compiler-Assignment-Intro/return-in-while.cc):

    int main() {
      int i = 0;
    
      while (i++ < 5) {
          return 71;
      }
    
      return 52;
    }

For the next exercise we need to know how to implement if-then-else in Webassembly. We could try to find out  by consulting the documentation on

- [typing rules](https://webassembly.github.io/spec/core/valid/instructions.html#) and
- [operational semantics](https://webassembly.github.io/spec/core/exec/instructions.html#)

but this level of detail is maybe only needed if you want to implement a compiler from Wat to Wasm and/or the virtual machine executing Wasm. Instead look at the articles

- [Writing WebAssembly By Hand](https://blog.scottlogic.com/2018/04/26/webassembly-by-hand.html)
- [Build your own WebAssembly Compiler](https://blog.scottlogic.com/2019/05/17/webassembly-compiler.html)

and search for if then else.

**Exercise 4:** Write a Webassembly program that has the same observable behaviour as [`redeclare-in-if-1.cc`](Compiler-Assignment-Intro/redeclare-in-if-1.cc):

    int main () {
      int x0 = 32 ;
      if (0 < 0 - 0) x0 = true ;
      else x0 = false ;
      return x0;
    }
    
**Hint:** Write first a solution for Exercise 4 without if-then-else. This is basically Exercise 1. 

For the next exercise, we need to think about how to implement shadowing in Webassembly. Importantly, in Webassembly, all local variables in a function have to be declared at the beginning of the function. But then how do we deal with a variable like `x0` which is redeclared in  the conditional?

One way of solving the problem is to count the levels of scope (= blocks) and to have two copies of `x0`, one called `x0$0` and the other `x0$1`.

**Exercise 5:** Write a Webassembly program that has the same observable behaviour as [`redeclare-in-if.cc`](Compiler-Assignment-Intro/redeclare-in-if.cc):

    int main () {
      int x0 = 32 ;
      if (0 < 0 - 0) bool x0 = true ;
      else bool x0 = false ;
      return x0;
    }
    
I will make solutions available in [Compiler-Assignment-Intro](Compiler-Assignment-Intro/wat-programs). If you look at `redeclare-in-if.wat` you will find that all the declarations have been collected to the beginning of the function. This is done in the compiler by the function `collectDecls`, which implements shadowing by making the *scope* (encoded by the nesting number of the blocks) part of the name of the variable: A variable with suffix `$0` has nesting number 0, a variable with suffix `$1` has nesting number 1, etc.
