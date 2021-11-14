# compiler-construction-2022

## overview

In this course we will build a compiler for a substantial fragment of C++, covering all stages from writing a grammar, via typechecking and interpretation to code generation.

I think this is a great course with most of the credit going to [Aarne Ranta](http://www.cse.chalmers.se/~aarne/) and [Samuel Balco](https://gdlyrttnap.pl/). Aarne Rante wrote the book [Implementing Programming Languages](http://www.grammaticalframework.org/ipl-book/), which we will follow for the first 5 chapters available [here](http://www.cse.chalmers.se/edu/year/2012/course/DAT150/lectures/plt-book.pdf). For Chapter 6 on code generation we will deviate and compile to [Webassembly](https://webassembly.org/) instead of to the JVM. Samuel Balco implemented the typechecker, interpreter and code generation and we will start the corresponding assignments from his template files. For background on automata and formal languages we will select sections of the classic book by [Hopcroft-Motwani-Ullman](http://ce.sharif.edu/courses/94-95/1/ce414-2/resources/root/Text%20Books/Automata/John%20E.%20Hopcroft,%20Rajeev%20Motwani,%20Jeffrey%20D.%20Ullman-Introduction%20to%20Automata%20Theory,%20Languages,%20and%20Computations-Prentice%20Hall%20(2006).pdf).

There will be 4 assignments and a report. The report will be similar to a take home exam, but divided into 4 separate parts with 4 separate deadlines throughout the semester.

In more detail, the assignments, each worth 15%, will cover
- parsing, 
- typechecking, 
- interpretation, 
- compiling to Webassembly.

In the report, worth 40%, you will solve exercises on 
- regular expressions and finite automata, 
- context-free grammars, pushdown automata and LALR-parsing, 
- type-checking and type-inference,
- interpretation and operational semantics.

## prerequisites

We build on the Programming Languages course. It is possible to take Compiler Construction before Programming Languages, if you know already (or teach yourself) Haskell. 