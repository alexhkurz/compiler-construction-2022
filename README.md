# compiler-construction-2022

## Quick Links

- [Lecture by Lecture](https://github.com/alexhkurz/compiler-construction-2022/blob/main/lecture-by-lecture.md)  
- [Introduction to Automata Theory, Languages, and Computation](http://ce.sharif.edu/courses/94-95/1/ce414-2/resources/root/Text%20Books/Automata/John%20E.%20Hopcroft,%20Rajeev%20Motwani,%20Jeffrey%20D.%20Ullman-Introduction%20to%20Automata%20Theory,%20Languages,%20and%20Computations-Prentice%20Hall%20%282006%29.pdf)  
- [Implementing Programming Languages](http://www.cse.chalmers.se/edu/year/2012/course/DAT150/lectures/plt-book.pdf)  
- [Syllabus](https://github.com/alexhkurz/compiler-construction-2022/blob/main/syllabus.md)  
- [The Project](project.md)  

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

We build on the Programming Languages course. In particular, Haskell is a prerequisite. 3 of the 4 assignments will be solved by writing Haskell code that works by recursion over algebraic data types.

## Discussion Topics

- [Interfaces - The Most Important Software Engineering Concept](https://blog.robertelder.org/interfaces-most-important-software-engineering-concept/) ... abstraction leaks, side-channel attacks, leaky vs specific interfaces, technical debt, Why do People Still Use the Command Line?, Why is Python So Popular?, Why is Enterprise Software Usually Java/C++?
- [Pandoc](https://en.wikipedia.org/wiki/Pandoc) is a universal [document converter](https://pandoc.org/try/). For example, one can use it to [convert markdown to latex](https://gist.github.com/DannyQuah/04b46cd583f0e87cea7b5009adfb9c5d). Behind the scenes, pandoc is an application of parsing, ASTs and linearization, quoting from the [Pandoc API documentation](https://hackage.haskell.org/package/pandoc): "Pandoc has a modular design: it consists of a set of readers, which parse text in a given format and produce a native representation of the document (an abstract syntax tree or AST), and a set of writers, which convert this native representation into a target format. Thus, adding an input or output format requires only adding a reader or writer."

- MIT: [The Missing Semester of Your CS Education](https://missing.csail.mit.edu/2020/course-shell/) contains a lot of topics that also show up in this course. The first one is about using the shell (paths, etc). I will post more details once I watched the videos myself. In the meanwhile, all comments welcome. 

- Leslie Lamport on [Specifications](https://www.programmingtalks.org/talk/thinking-above-the-code)

    Many of the topics of his talk showed up in class. For example, we use reg exps as specifications of NFAs and NFAs as specifications for DFAs and DFAs as specifications for code. Another one is that formal specifications are needed if you want to use tools (we have seen a bit of this with BNFC last semester).

    Lamport is famous for many things, not only TLA (which appears in the talk). Here is a presentation on [Byantine Agreement](https://www.cs.cornell.edu/courses/cs6410/2018fa/slides/18-distributed-systems-byzantine-agreement.pdf) which is one of the important ideas in the prehistory of bitcoin. Oh, and by the way, the La in LaTeX refers to him.

    He also has some catchy quotes in the talk, eg:

    "Everyone thinks they think. But if you don't write down your thoughts you are fooling yourself."  
    "You should think before you code. A spec is simply what you write before coding."  
    "Thinking is hard. It is easier to think you are thinking."  
    "If you don't start with a spec every piece of code you write is a patch."  
