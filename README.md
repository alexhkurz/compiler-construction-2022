# compiler-construction-2022

## Overview

In this course we build a compiler for a substantial fragment of C++, covering all stages from writing a grammar, via typechecking and interpretation to code generation.

I think this is a great course with most of the credit going to [Aarne Ranta](http://www.cse.chalmers.se/~aarne/) and [Samuel Balco](https://gdlyrttnap.pl/). Aarne Rante wrote the book [Implementing Programming Languages](http://www.grammaticalframework.org/ipl-book/), which we follow for the first 5 chapters, available [online](http://www.cse.chalmers.se/edu/year/2012/course/DAT150/lectures/plt-book.pdf). For Chapter 6 on code generation we deviate and compile to [Webassembly](https://webassembly.org/) instead of to the JVM. Samuel Balco implemented the typechecker, interpreter and code generation and we start the corresponding assignments from his template files. For background on automata and formal languages we select sections of the classic book by [Hopcroft-Motwani-Ullman](http://ce.sharif.edu/courses/94-95/1/ce414-2/resources/root/Text%20Books/Automata/John%20E.%20Hopcroft,%20Rajeev%20Motwani,%20Jeffrey%20D.%20Ullman-Introduction%20to%20Automata%20Theory,%20Languages,%20and%20Computations-Prentice%20Hall%20(2006).pdf).

There are four assignments and a report. The report is similar to a take home exam (but divided into four separate parts and deadlines throughout the semester) plus one final project.

In more detail, the **programming assignments**, each worth 15%, will cover
- parsing, 
- typechecking, 
- interpretation, 
- compiling to Webassembly.

In these assignments an important method of debugging will be to reduce the problematic code to minimal form and then to execute it pen-and-paper. This requires understanding of the relevant algorithms, which are the topic of **part 1 of the report**, worth 20% (half of it for completion in time for the weekly deadline, half of it for correctness at the end of term), which will consist of solutions to selected exercises on 
- regular expressions and finite automata, 
- context-free grammars, pushdown automata and LALR-parsing, 
- type-checking and type-inference,
- interpretation and operational semantics.

An example LaTeX file for the report is [here](https://github.com/alexhkurz/compiler-construction-2022/tree/main/report). 

**Part 2 of the report**, worth 15%, will be a project in which you choose a language (such as C) and a compiler (such as gcc) and compile example programs to assembly and explain in some detail
- how the compilation works and 
- how the assembly program is executed on the machine.

5% of the grade will be for participation.

## Prerequisites

We build on the Programming Languages course. 
